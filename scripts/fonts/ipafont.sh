#!/bin/sh

url=https://moji.or.jp/wp-content/ipafont/IPAfont/IPAfont00303.zip

curl -L -o /tmp/IPAfont00303.zip $url
mkdir -p $HOME/.fonts/IPAfont

unzip /tmp/IPAfont00303.zip -d $HOME/.fonts/IPAfont/
fc-cache -fv

rm -rf /tmp/IPAfont00303.zip
