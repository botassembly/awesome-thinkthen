# Evaluate GLiNER2.5-Decide

Status: Open

GLiNER2.5-Decide (https://huggingface.co/fastino/GLiNER2.5-Decide) is a 340M DeBERTa-v3-large classifier under Apache 2.0. It takes any label set at call time, single or multi-label, with thresholds and label descriptions. Its card reports 60.2% on `fastino/fast-decisions` against 57.6% for a Jev version. It ships as a Python library (`gliner2`) with no HTTP API. Fastino also sells hosted serving.

ThinkThen reaches a model only through the Jev wire shape. Using this model needs a small server that presents that shape. See `2026-09-24-serve-any-model-as-a-jev-backend.md`. Then run the compliance check and Beatles Bench.
