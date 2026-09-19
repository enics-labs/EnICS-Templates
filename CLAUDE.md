# EnICS Templates

This repository is the EnICS Labs LaTeX template framework (Bar-Ilan University). It is the *source* project that students copy; it is not itself a manuscript.

- The eight document types live in `Templates/`. The root `main.tex` is only a selector that `\input`s one of them for testing.
- Shared preamble: `packages/configuration.tex` (version stamp, `\ifguide`, per-type flags), `packages/basic_packages.sty` (conditional package loading), `packages/macros.tex`, `newcommands/*.tex` (units and acronyms), `bibliography/bibliography.tex`.
- Guidance text is conditional on `\ifguide` and lives in `Templates/templateText.tex` (used via `\guide{tag}`), `\guidenote{...}`, or a `guidance` environment. Never write guidance as plain text in a template.
- Anything needed at compile time must live outside `Templates/` (students delete that folder).
- Theses and proposals compile with LuaLaTeX (Hebrew front matter from `AuxiliaryPages/*.tex`); everything else with pdfLaTeX. Both engines must keep working.
- Verify changes with `bash Utilities/build_all.sh -n` (builds every template with and without guidance).
- The maintainer works in Overleaf and pushes to GitHub manually when a version is ready. Do not commit or push unless asked. When releasing, bump `\enicstemplateversion` and add to `CHANGELOG.md`.

To start a manuscript from this project, use the `enics-manuscript` skill in `.claude/skills/`.
