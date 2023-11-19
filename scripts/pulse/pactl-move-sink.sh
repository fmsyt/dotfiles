#!/usr/bin/env bash

if ! command -v pactl &> /dev/null; then
    echo "pactl not found"
    exit 1
fi

if [ $# -eq 0 ]; then
    echo "Usage: pacmd-move-sink.sh <sink_id | sink_name>"
    echo "Available sinks:"
    pactl list short sinks | awk '{print "    " $1 "\t" $2}'

    exit 1
fi

readarray -d "\n" ids < <(pactl list short sink-inputs | awk '{print $1}')

for i in ${ids[@]}; do
    pactl set-default-sink $1 && pactl move-sink-input $i $1
done
