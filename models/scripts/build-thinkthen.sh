#!/bin/sh
# Build the ThinkThen 0.2 development command from source, at the commit the local guides tested.
#   models/scripts/build-thinkthen.sh [COMMIT]
# ThinkThen 0.2 is not released yet. Needs git and a Rust toolchain. Leaves the command at thinkthen-src/target/release/thinkthen.
set -eu
commit=${1:-65ce9d5af630fc3a4b7b6c553716cc3c2ea3ad16}
git clone https://github.com/botassembly/thinkthen.git thinkthen-src
cd thinkthen-src
git checkout "$commit"
cargo build --locked --release -p thinkthen --bin thinkthen
./target/release/thinkthen --version
