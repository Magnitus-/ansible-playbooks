#!/bin/bash

if command -v nerdctl >/dev/null 2>&1; then
    export COMMAND="nerdctl"
elif command -v docker >/dev/null 2>&1; then
    export COMMAND="docker"
else
    echo "Neither docker nor nerdctl is found in the PATH"
    exit 1;
fi

(cd ..; bash -c '$COMMAND run -it --rm --network host -v ~/.ssh:/root/.ssh -v $(pwd):/opt/ansible -w /opt/ansible local-ansible:latest sh')