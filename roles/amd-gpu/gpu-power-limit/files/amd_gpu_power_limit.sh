#!/bin/sh

set -e

for i in $(seq 1 30); do
    if amd-smi list >/dev/null 2>&1; then
        break
    fi

    if [ "$i" -eq 30 ]; then
        echo "amd-smi did not become ready"
        exit 1
    fi

    sleep 1
done

amd-smi set --gpu all --power-cap $GPU_POWER_LIMIT ppt0 