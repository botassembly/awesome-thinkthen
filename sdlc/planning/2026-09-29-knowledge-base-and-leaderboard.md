# Ian's rulings for the list, 2026-09-29

Dictated after the first standings work. This note steers the queue.

1. **No harvesting from JevBench.** The board gets a link; the open-models list stays out. A model earns an entry here by being tested, not by being ranked. Most open entries will fall away, and the list will not spend time on them. The seed issue closes with this ruling.
2. **The core is Jev, Liquid d1, and OpenAI's Decisions API** once it ships. Kev and Laya hold their places because they were tested.
3. **Shape.** The root README holds at most 10 leaderboard entries. A second page (`runs.md`) holds every run. One page per run (`reports/`) in a standard format, linked from the second page.
4. **Papers as a subpage** (`papers.md`), catalogued, with Markdown copies fetched through markxiv (swap `arxiv.org` for `markxiv.org` in the abs URL). The repository doubles as a downloadable ThinkThen knowledge base, holding internet content beyond ThinkThen's own docs. Curating starts from the 31-paper arXiv review in Ian's notes; check each paper's license before a fetched copy ships in a public repo.
5. **No pull requests.** Contributors open an issue with the check output; maintainers make the change. `CONTRIBUTING.md` says so, and the deck's backends slide copy must follow (issue filed with the marketing queue).
6. **Benchmarks section:** Beatles Bench, the JevBench board, and jevbench.dev. A private benchmark may join the leaderboard later; it names itself when it does.
7. **Support goal:** System One plus whatever decision format OpenAI ships. Liquid speaks System One natively; Kev does too; Laya reached it through a shim.
8. **Ollama entries wait on the check.** nimble and tev1 speak System One through Ollama 0.35, but the compliance check still carries three criticals, all the object-criteria corner. They list when the check passes on either side (Ollama accepting objects, or ThinkThen's portable serialization landing). Filed 2026-09-30.
