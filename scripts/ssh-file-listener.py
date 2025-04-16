import argparse
import os
import subprocess
import sys

from email.parser import BytesParser
from email.policy import default
from http.server import BaseHTTPRequestHandler, HTTPServer

parser = argparse.ArgumentParser(
    description="SSH接続時に、接続元の端末に対してファイルを受信するためのスクリプト"
)

parser.add_argument(
    '--host',
    type=lambda x: tuple(map(int, x.split('.'))),
    default=[0, 0, 0, 0],
    help='SSH接続を待ち受けるホスト名またはIPアドレス',
)

parser.add_argument(
    '--port',
    type=int,
    default=12003,
    help='SSH接続を待ち受けるポート番号',
)

parser.add_argument(
    '-d',
    '--detach',
    action='store_true',
    help='デタッチモードで実行する場合は指定',
)

parser.add_argument(
    '-o',
    '--output',
    type=str,
    default='tmp',
    help='受信したファイルを保存するディレクトリ',
)

parser.add_argument(
    '-v',
    '--verbose',
    action='store_true',
    help='詳細なログを表示する場合は指定',
)

parser.add_argument(
    '--no-cleanup',
    action='store_true',
    help='受信したファイルを削除しない場合は指定',
)


dotfiles_dir = os.path.dirname(os.path.realpath(__file__))
script_path = os.path.join(dotfiles_dir, 'linux', 'utils', 'open.sh')
if not os.path.isfile(script_path):
    print(f"open: {script_path}: No such file or directory", file=sys.stderr)
    sys.exit(1)

args = parser.parse_args()

sysname = os.uname().sysname

received_files: list[str] = []


def print_verbose(message):
    """詳細なログを表示する関数"""
    if args.verbose:
        print(f"[VERBOSE] {message}")


def file_open(file_path: str):
    """ファイルを開く関数"""

    try:
        subprocess.Popen(['bash', script_path, file_path])

    except Exception as e:
        print_verbose(f"Failed to open file {file_path}: {e}")


class FileRequestHandler(BaseHTTPRequestHandler):
    """HTTPリクエストを処理するクラス"""

    def do_GET(self):
        """return plain/text"""
        self.send_response(200)
        self.send_header('Content-type', 'text/plain; charset=utf-8')
        self.end_headers()

        self.wfile.write("ssh-file-listener.py is running".encode('utf-8'))

    def do_POST(self):
        """POSTリクエストを処理する関数"""

        # multipart/form-dataの処理
        content_type = self.headers.get('Content-Type')
        if content_type is None or not content_type.startswith('multipart/form-data'):
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b"Invalid Content-Type")
            return

        content_length = int(self.headers.get('Content-Length', 0))
        body = self.rfile.read(content_length)

        headers = f"Content-Type: {content_type}\n\n".encode()
        msg = BytesParser(policy=default).parsebytes(headers + body)

        for part in msg.iter_parts():
            filename = part.get_filename()
            if filename:
                file_path = os.path.join(args.output, filename)
                with open(file_path, 'wb') as f:
                    f.write(part.get_payload(decode=True))
                print_verbose(f"File saved to {file_path}")

                received_files.append(file_path)
                file_open(file_path)

        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"File received")
        print_verbose(f"File received and saved to {file_path}")


def main():
    # 引数の処理
    output_dir = args.output
    no_cleanup = args.no_cleanup

    # 出力ディレクトリの作成
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    if args.detach:
        # デタッチモードで実行する場合
        pid = os.fork()
        if pid > 0:
            # 親プロセスは終了
            print_verbose(f"Detached process PID: {pid}")
            return

    host = '.'.join(map(str, args.host))

    # HTTPサーバーの起動
    server_address = (host, args.port)
    httpd = HTTPServer(server_address, FileRequestHandler)
    print_verbose(f"Starting server on {host}:{args.port}")

    try:
        # サーバーを起動
        httpd.serve_forever()
    except KeyboardInterrupt:
        print_verbose("Server interrupted by user")
    except Exception as e:
        print_verbose(f"Server error: {e}")
    finally:
        httpd.shutdown()
        print_verbose("Server shutdown")

        if not no_cleanup:
            # 受信したファイルを削除
            for file_path in received_files:
                try:
                    os.remove(file_path)
                    print_verbose(f"Deleted file: {file_path}")
                except Exception as e:
                    print_verbose(f"Failed to delete file {file_path}: {e}")


if __name__ == "__main__":
    main()
