#!/usr/bin/env bash

command pacmd list-sinks | grep -A 22 '* index' | grep 'volume: front' | awk '{print $3}'
