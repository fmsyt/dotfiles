# 画面レイアウトの設定

[xrandr](https://wiki.archlinux.jp/index.php/Xrandr)

> xrandr は RandR("Resize and Rotate") X Window System 拡張の公式設定ユーティリティです。xrandr を使うことで画面のサイズや向き、反転などを設定できます。

## 設定例

2つのディスプレイを使用して、片方を縦向きに設定する例。

`./Xsetup.conf.d/sample.sh`

```bash
#!/bin/bash

DP0_WIDTH=2560
DP0_HEIGHT=1440

DP0_OUTPUT=DP-0

xrandr --output $DP0_OUTPUT --rotate left --mode ${DP0_WIDTH}x${DP0_HEIGHT} --pos 0x0

HD0_WIDTH=3840
HD0_HEIGHT=2160

HD0_OUTPUT=HDMI-0

xrandr --output $HD0_OUTPUT --rotate normal --mode ${HD0_WIDTH}x${HD0_HEIGHT} --pos ${DP0_HEIGHT}x200 --primary
```
