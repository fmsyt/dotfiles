au BufRead,BufNewFile **/.ssh/shared/*.conf setf sshconfig
au BufRead,BufNewFile **/.ssh/config setf sshconfig
au BufRead,BufNewFile **/ssh_config setf sshconfig
au BufRead,BufNewFile **/sshd_config setf sshconfig
au BufRead,BufNewFile **/ssh_config.d/*.conf setf sshconfig
au BufRead,BufNewFile **/sshd_config.d/*.conf setf sshconfig

