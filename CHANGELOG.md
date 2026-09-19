# Changelog

## 2026.09

- Fixed the ACM Journal template, which hung forever instead of compiling. The `silence` package and the `acmart` class are incompatible on current package versions: loading both sends the compile into an infinite loop. `silence` is now loaded in `packages/basic_packages.sty` (after the template has set its type flag) and skipped for ACM, along with the one `\WarningFilter` that applies to it. This was a pre-existing problem, not a regression.
- Also for ACM: `titlesec` is no longer loaded there. It redefines `\section` and friends, which `acmart` rejects outright ("An attempt to redefine \section detected").
- Guidance text: fixed words running together at line breaks (for example "the project.If you are"). The `catchfilebetweentags` package does not turn a line ending into a space, so every paragraph in `Templates/templateText.tex` must stay on one line. Noted at the top of that file.
- `\TBD` now ends with `\xspace`, like `\needref` and `\needval`, so it no longer swallows the following space.
- `Utilities/build_all.sh` prints the LaTeX errors of each failing template instead of only a summary line, and the CI workflow keeps the `.log` files alongside the PDFs.
- `Utilities/build_all.sh` now runs at most a few builds at a time (`JOBS`, default half the cores capped at 4). Starting all 22 at once starved the LuaLaTeX thesis builds until they hit their timeout.
- Added `.gitignore` for LaTeX build artifacts (aux, log, bbl, glossary, minted cache, clipboard files). Figure and example PDFs are deliberately not ignored.
- A file in `Templates/` can now be opened and built where it sits, for a quick preview. Its `\input{packages/...}` paths are written relative to the project root, so building it in place used to fail with "File `packages/configuration.tex' not found". The VS Code settings now add the project root to `TEXINPUTS` and `BIBINPUTS`, and `\graphicspath` gained two fallback entries. Writing a manuscript still means making the template the root `main.tex`.
- Added `.vscode/settings.json` so the project builds in VS Code (LaTeX Workshop) out of the box. It passes `-shell-escape`, which `minted` requires and without which the build fails with "minted v3+ executable is not installed...". It also adds a LuaLaTeX recipe for theses and proposals, a variant that runs `makeglossaries` for the list of acronyms, and it stops LaTeX Workshop from deleting `main.log` after each build, which used to leave a failed build with no error message to read.

- Version stamp: `\enicstemplateversion` in `packages/configuration.tex`. Derived projects record which template version they started from.
- New procedure: the chosen template becomes `main.tex` in the project root. Nothing else needs renaming and the Overleaf main document never changes.
- Guidance switch: all colored guidance text is conditional on `\ifguide`. Set `\guidefalse` once to remove all of it. Templates use `\guide{tag}`, `\guidenote{...}` and the `guidance` environment (see `packages/macros.tex`).
- Thesis and proposal front matter in LaTeX: English and Hebrew title pages, supervisor pages and the Hebrew abstract are typeset from `AuxiliaryPages/*.tex` when compiling with LuaLaTeX (David CLM font). The `.docx` route still works under pdfLaTeX.
- Title pages carry the same border as the Word originals: 24pt (0.85cm) in from each page edge, 0.5pt thick, drawn by `\enicspageframe` (defined in `packages/macros.tex`). It goes on the title pages only, matching the examples, so supervisor pages, the Hebrew table of contents and the abstract stay unframed.
- Runtime assets moved out of `Templates/` so the folder can be deleted safely: `AuxiliaryPages/` and `Reply_To_Reviewers.tex` are in the root, `sig-alternate.cls` and `flushend.sty` are in `packages/`.
- `Reply_To_Reviewers.tex` is a subfile of `main.tex` regardless of the document class, can be compiled standalone, and gets an `\editorsection` macro.
- All staff `.bib` files are loaded by `bibliography/bibliography.tex` (placeholder entries removed from the stubs).
- `ai_glossary.tex` is loaded by every template.
- Packages: `subfigure` replaced by `subfig` (`\subfloat`), `color` replaced by `xcolor`, `iftex` added, `\ProvidesPackage` path fixed.
- Abstract character counter no longer warns by default (`charlim` defaults to 100000).
- Fixed the unbalanced parenthesis in the IEEE journal `\thanks`.
- Added `Utilities/build_all.sh` and a GitHub Actions workflow that compile every template on each push.
- Added the `enics-manuscript` Claude Code skill (`.claude/skills/`) and a `CLAUDE.md`.
- README rewritten to match the actual folder layout.

## Earlier

- Template maintained on Overleaf with periodic pushes to GitHub. No changelog was kept.
