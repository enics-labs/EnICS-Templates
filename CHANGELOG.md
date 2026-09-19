# Changelog

## 2026.09

- Version stamp: `\enicstemplateversion` in `packages/configuration.tex`. Derived projects record which template version they started from.
- New procedure: the chosen template becomes `main.tex` in the project root. Nothing else needs renaming and the Overleaf main document never changes.
- Guidance switch: all colored guidance text is conditional on `\ifguide`. Set `\guidefalse` once to remove all of it. Templates use `\guide{tag}`, `\guidenote{...}` and the `guidance` environment (see `packages/macros.tex`).
- Thesis and proposal front matter in LaTeX: English and Hebrew title pages, supervisor pages and the Hebrew abstract are typeset from `AuxiliaryPages/*.tex` when compiling with LuaLaTeX (David CLM font). The `.docx` route still works under pdfLaTeX.
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
