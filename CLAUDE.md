# EnICS Templates

This repository is the EnICS Labs LaTeX template framework (Bar-Ilan University). It is the *source* project that students copy; it is not itself a manuscript.

- The eight document types live in `Templates/`. The root `main.tex` is only a selector that `\input`s one of them for testing.
- Shared preamble: `packages/configuration.tex` (version stamp, `\ifguide`, per-type flags), `packages/basic_packages.sty` (conditional package loading), `packages/macros.tex`, `newcommands/*.tex` (units and acronyms), `bibliography/bibliography.tex`.
- Guidance text is conditional on `\ifguide` and lives in `Templates/templateText.tex` (used via `\guide{tag}`), `\guidenote{...}`, or a `guidance` environment. Never write guidance as plain text in a template.
- In `Templates/templateText.tex`, keep each paragraph on ONE line. `catchfilebetweentags` does not turn a line ending into a space, so text split across lines renders with the words run together.
- `packages/basic_packages.sty` skips `silence` and `titlesec` under `\ifacmjournal`: the first hangs with `acmart`, the second is rejected by it. Anything conditioned on a template flag must load from `basic_packages.sty`, not `configuration.tex`, because the flags are set in between.
- Anything needed at compile time must live outside `Templates/` (students delete that folder).
- Theses and proposals compile with LuaLaTeX (Hebrew front matter from `AuxiliaryPages/*.tex`); everything else with pdfLaTeX. Both engines must keep working.
- Verify changes with `bash Utilities/build_all.sh -n` (builds every template with and without guidance).
- Every compile needs `-shell-escape` (minted). `.vscode/settings.json` sets this for LaTeX Workshop, with recipes for pdfLaTeX papers and LuaLaTeX theses; without the flag the build fails with "minted v3+ executable is not installed...".
- Template files under `Templates/` use paths relative to the project root, so they only build in place because `.vscode/settings.json` puts the root on `TEXINPUTS`/`BIBINPUTS` and `\graphicspath` has `../` fallbacks. Keep `.` first in those paths: a recursive `//` entry makes LaTeX pick up a stale `comment.cut` from elsewhere in the project and silently splice the wrong text into the PDF.
- The maintainer works in Overleaf and pushes to GitHub manually when a version is ready. Do not commit or push unless asked. When releasing, bump `\enicstemplateversion` and add to `CHANGELOG.md`.

To start a manuscript from this project, use the `enics-manuscript` skill in `.claude/skills/`.
