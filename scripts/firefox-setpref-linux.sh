#!/bin/bash
echo "Firefox の設定を更新しています: browser.tabs.loadBookmarksInTabs = true"
firefox --setPref browser.tabs.loadBookmarksInTabs true
echo "完了しました。"
