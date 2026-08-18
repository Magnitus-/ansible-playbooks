#!/usr/bin/env bash

set -euo pipefail

SERVER_BINARY_ARRAY=(/opt/llama.cpp/vulkan/llama-*/llama-server)
SERVER_BINARY="${SERVER_BINARY_ARRAY[0]}"

TENSOR_SPLIT=""
if [ ! -z "$SERVER_TENSOR_SPLIT" ]; then
    TENSOR_SPLIT="--tensor-split $SERVER_TENSOR_SPLIT"
fi

MAX_MODELS=""
if [ ! -z "$SERVER_MAX_MODELS" ]; then
    MAX_MODELS="--models-max $SERVER_MAX_MODELS"
fi

TLS_CERT=""
TLS_KEY=""
if [ ! -z "$SERVER_TLS_CERT" ]; then
    TLS_CERT="--ssl-cert-file $SERVER_TLS_CERT"
    TLS_KEY="--ssl-key-file $SERVER_TLS_KEY"
fi

API_KEYS=""
if [ ! -z "$SERVER_API_KEYS" ]; then
    API_KEYS="--api-key-file $SERVER_API_KEYS"
fi

exec $SERVER_BINARY \
--split-mode layer \
$TENSOR_SPLIT \
--models-dir $SERVER_MODEL_DIR \
$MAX_MODELS \
$TLS_CERT \
$TLS_KEY \
$API_KEYS \
--host 0.0.0.0 \
--port $SERVER_PORT