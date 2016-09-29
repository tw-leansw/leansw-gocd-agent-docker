#!/bin/sh
set -e
if [ "$#" -eq 0 -o "${1:0:1}" = '-' ]; then
        set -- docker daemon \
                --host=unix:///var/run/docker.sock \
                --host=tcp://0.0.0.0:2375 \
                --registry-mirror=https://8xwd88nd.mirror.aliyuncs.com
                --storage-driver=vfs \
                "$@"
fi
/run/go-agent/agent.sh
