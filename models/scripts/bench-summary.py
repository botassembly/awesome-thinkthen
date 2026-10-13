#!/usr/bin/env python3
"""Summarize one Beatles Bench knowledge run the way this list's reports do.

usage: bench-summary.py BENCH_CHECKOUT RUN_DIR

Scores with the bench's own credit rule (scripts/score/score.py): decide at 0.5, choose takes its winner, and a tie
that holds the truth splits its share. Prints the full dataset, the Beatles-only view (without the two
reversal-general categories), the hard set (the 505 questions from the seven categories where Jev scores worst),
refusals, the median wall seconds a request, the input tokens, and the share right in each category.
"""
import json
import statistics
import sys
from pathlib import Path

bench, run = Path(sys.argv[1]), Path(sys.argv[2])
sys.path.insert(0, str(bench / "scripts" / "score"))
import score  # noqa: E402

HARD = {"lexical-trap", "lexical-trap-control", "multi-hop", "none-of-these", "reversal", "shared-lead"}
GENERAL = {"reversal-general", "reversal-general-shared-name"}

rows = score.load(run)
hard = [r for r in rows if r[0]["category"] in HARD or (r[0]["category"] == "forward" and r[0]["kind"] == "year")]
beatles = [r for r in rows if r[0]["category"] not in GENERAL]


def share(sel):
    return sum(score.credit(r) for r in sel) / len(sel)


answers = [json.loads(line) for line in open(run / "answers.jsonl", encoding="utf-8")]
print(f"full dataset {len(rows)}: {share(rows):.1%}")
print(f"Beatles-only {len(beatles)}: {share(beatles):.1%}")
print(f"hard set {len(hard)}: {share(hard):.1%}")
print(f"refusals: {sum(1 for a in answers if a.get('probabilities') is None)}")
print(f"median wall s a request: {statistics.median(a['wall_s'] for a in answers):.3f}")
print(f"input tokens: {sum(a.get('input_tokens') or 0 for a in answers):,}")
for c in score.categories(rows):
    sel = [r for r in rows if r[0]["category"] == c]
    print(f"{c}\t{share(sel):.3f}")
