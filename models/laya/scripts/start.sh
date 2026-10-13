#!/bin/sh
# Start the Laya sidecar on 127.0.0.1:8011, in the folder install.sh ran in. It serves POST /v1/systemone.
# It loads aac6fef/laya-mlx once at startup and answers under the model name laya:laya-mlx whatever model a request names.
exec laya-venv/bin/python stuntdouble/sidecars/laya.py --port 8011
