#!/bin/sh
# Serve the Strands decider checkpoint under MLX at 127.0.0.1:8000, the mlx built-in's default address.
# The model id is the checkpoint basename, strands-decider-2B-hobson-v19, the built-in's default model.
# The first start downloads the checkpoint and its Qwen3.5-2B base, about 4.4 GB.
exec strands-env/bin/strands-decider serve StrandsAgents/strands-decider-2B-hobson-v19 \
  --device mlx --host 127.0.0.1 --port 8000
