---
name: enics-manuscript
description: Set up and maintain LaTeX manuscripts based on the EnICS Templates framework (EnICS Labs, Bar-Ilan University). Four modes - (1) start a NEW manuscript (IEEE journal or conference, ACM journal or conference, MSc or PhD thesis, research proposal, ISF proposal) from the template, filled in, stripped of guidance and verified to compile; (2) ADOPT the framework into an existing LaTeX project; (3) add a REPLY-to-reviewers letter to a journal paper; (4) UPDATE an older EnICS-based project to the latest template version. Trigger on phrases like "start a new EnICS manuscript", "new paper/thesis/proposal from the EnICS template", "set up an IEEE/ACM paper", "apply the EnICS template to this project", "add a reply to reviewers", "update the EnICS template files".
---

# EnICS manuscript skill

The EnICS Templates framework is a LaTeX project with one shared preamble and eight document types. This skill turns a copy of it into a clean manuscript, or brings its machinery into an existing project. Work autonomously on anything reversible; ask only for the facts that only the author knows (document type, title, authors).

## Facts about the framework you must know

- **main.tex is always the document.** The full body of the manuscript lives in `main.tex` in the project root. Overleaf compiles it; `Reply_To_Reviewers.tex` is a subfile of it.
- **Preamble order** in every template: `\documentclass...`, `\input{packages/configuration}` followed by the type flag(s) and `\guidetrue`, `\usepackage{packages/basic_packages}`, `\input{packages/macros}`, the `newcommands/*` inputs ending with `this_glossary`, then type-specific preamble.
- **Flags** (in `packages/configuration.tex`, all false by default): `\ieeejournaltrue`, `\ieeeconferencetrue`, `\acmjournaltrue`, `\microtrue` (ACM conference), `\thesistrue`, `\proposaltrue`, `\isftrue`, plus `\biographiestrue`, `\replytoreviewerstrue`, and the guidance switch `\guidetrue`/`\guidefalse`.
- **Guidance text** is conditional on `\ifguide` and appears in three forms: `\guide{tag}` (pulls a block from `Templates/templateText.tex`), `\guidenote{...}` (inline red note), and `\begin{guidance} ... \end{guidance}` blocks. `\guidefalse` hides all of it; deleting it is optional afterwards.
- **Version**: `\newcommand{\enicstemplateversion}{YYYY.MM}` in `packages/configuration.tex`.
- **Engines**: theses and proposals compile with LuaLaTeX (the Hebrew front matter in `AuxiliaryPages/*.tex` needs it, via `\ifluatex`); all other types with pdfLaTeX. Everything needs `-shell-escape` (minted).
- **Per-project files**: `newcommands/this_glossary.tex` (acronyms and macros), `bibliography/this_bibliography.bib` (references), `AuxiliaryPages/abstract_hebrew.tex` (theses and proposals), `Reply_To_Reviewers.tex` (journals).
- **House macros** you should use and never redefine: `\figref`, `\secref`, `\tblref`, `\eqref`, `\chapref`, `\red`, `\blue`, `\needref`, `\TBD`, `\etal`, `\ie`, `\eg`, `\X`, units like `\nm`, `\um`, `\uW`, `\GHz` (see `newcommands/units.tex`), acronyms via `\gls{...}` and shorthands like `\sota`, `\soc`, `\dnn`.

Document types and their template files:

| Type (accept any of these words) | Template file | Engine | Extra files kept |
|---|---|---|---|
| ieee-journal, IEEE Transactions, TVLSI, TCAS, JSSC | `Templates/IEEE_Journal.tex` | pdflatex | `Bios/`, `Reply_To_Reviewers.tex` |
| ieee-conference, ISCAS, DATE, ESSCIRC, conference paper | `Templates/IEEE_Conference.tex` | pdflatex | |
| acm-journal, TODAES, TACO, JETC | `Templates/ACM_Journal.tex` | pdflatex | `Bios/`, `Reply_To_Reviewers.tex` |
| acm-conference, MICRO, ISCA, HPCA | `Templates/ACM_Conference.tex` | pdflatex | `packages/sig-alternate.cls`, `packages/flushend.sty` |
| msc-thesis | `Templates/MSc_Thesis.tex` | lualatex | `AuxiliaryPages/` |
| phd-thesis | `Templates/PhD_Thesis.tex` | lualatex | `AuxiliaryPages/` |
| research-proposal, thesis proposal | `Templates/Research_Proposal.tex` | lualatex | `AuxiliaryPages/` |
| isf, ISF proposal, grant | `Templates/ISF_Template.tex` | pdflatex | |

## Locating the template source

In order of preference:

1. The current project already contains `packages/configuration.tex` with `\enicstemplateversion` and a `Templates/` folder: it is a fresh copy of the framework. Work in place.
2. A local checkout of the framework exists (the maintainer keeps one at `~/Documents/Overleaf/EnICS_Templates`; also honor the `ENICS_TEMPLATES_DIR` environment variable). Copy from it.
3. Otherwise clone `https://github.com/enics-labs/EnICS-Templates` into a temporary directory and copy from there. Tell the user which version you fetched.

Never modify the framework source when copying from it.

## Mode 1: new manuscript

1. **Determine the type.** If the request does not say, ask once with the list above. Also ask, in the same question, for the title, the authors (with affiliations if not EnICS, and ORCIDs if known), and for theses the advisor and the date, in English and Hebrew. Missing answers are fine: leave the template placeholders.
2. **Create main.tex** from the template file (in place if the project is a framework copy, otherwise copy the needed folders first: `packages/`, `newcommands/`, `bibliography/`, `Figures/`, `Utilities/`, plus the extra files for the type from the table). Overwrite the selector `main.tex`.
3. **Fill in what you were told**: `\title`, `\author` block, `\thanks` funding line, `\newclipboard` name stays `output-main`, thesis or proposal metadata macros (`\thesisTitle`, `\thesisTitleHebrew`, ...), the manuscript ID in `Reply_To_Reviewers.tex` if known.
4. **Strip the guidance** unless the user asked to keep it:
   - Change `\guidetrue` to `\guidefalse`.
   - Replace each `\guide{tag}` line with a one-line `% TODO: <what goes here>` comment (for example `\guide{intro}` becomes `% TODO: introduction`). Keep the section structure.
   - Delete `\begin{guidance} ... \end{guidance}` blocks entirely, including the example figure and the "Template Usage Instructions" section they contain.
   - Delete `\guidenote{...}` calls (balance the braces; they can contain nested braces).
   - Replace placeholder body text such as `\blue{This work was kindly supported by...}` with a `% TODO` comment or leave a plain placeholder without color.
   - In `AuxiliaryPages/abstract_hebrew.tex` remove the guidance block and leave a `% TODO` comment.
5. **Prune the project**: delete `Templates/`, `Utilities/build_all.sh`, `.github/`, `CHANGELOG.md`, the old README, and the extra files not listed for the type (for example `AuxiliaryPages/` for a paper, `Reply_To_Reviewers.tex` and `Bios/` for a conference paper, `packages/sig-alternate.cls` and `packages/flushend.sty` unless ACM conference). Keep all `.bib` files (they cost nothing) and keep `.claude/` so the other modes keep working.
6. **Write a short project `CLAUDE.md`** stating: this is an EnICS manuscript of type X started from template version Y; `main.tex` is the document; where the per-project files are; which engine to use; and the house-macro rule.
7. **Verify the build** if a TeX distribution is available: `latexmk -pdf -shell-escape -interaction=nonstopmode main.tex` (or `-lualatex` for theses and proposals). Zero errors and zero undefined references are required. Fix what you broke; do not paper over template problems silently, report them. Remove the auxiliary files afterwards (`latexmk -c`), keep the PDF.
8. **Report**: the type and version, what was filled in, what remains as `TODO`, and for Overleaf users the two settings that matter (main document is `main.tex`; compiler is LuaLaTeX for theses and proposals).

## Mode 2: adopt the framework into an existing project

Be conservative: the goal is to gain the house macros, glossaries and bibliography without changing how the paper looks.

1. Find the main file (`\documentclass` and `\begin{document}`); ask if ambiguous. Read its whole preamble and note the class (IEEEtran journal or conference, acmart, book, article) to choose the flag.
2. Copy `packages/`, `newcommands/` and the shared `.bib` files (`abbreviations`, `general_biblography`, staff files) from the source. Do not overwrite any file that already exists in the project. If the project has its own `.bib`, add it to `bibliography/bibliography.tex` rather than renaming it.
3. Insert, right after `\documentclass`: the configuration input with the right flag and `\guidefalse`, `\usepackage{packages/basic_packages}`, `\input{packages/macros}`, and the `newcommands/*` inputs. Create `newcommands/this_glossary.tex` from the stub if missing.
4. Resolve conflicts in the existing preamble. Packages that `basic_packages.sty` already loads (comment, xcolor, tikz, lipsum, ulem, glossaries, xspace, setspace, titlesec, graphicx, subfig, multirow, array, booktabs, algorithm, algorithmicx, cite, amsmath, amssymb, amsfonts, mathtools, upgreek, nicefrac, siunitx, listings, minted, clipboard, catchfilebetweentags, pdfpages, hyperref, and for theses geometry and fancyhdr): comment the duplicate `\usepackage` line out with a note. If the user loaded one of them with options that differ (hyperref is the usual case), keep their options via `\PassOptionsToPackage{...}{package}` placed before `basic_packages`. Existing `\newcommand`s that collide with house macros (`\red`, `\blue`, `\figref`, `\etal`, unit macros) must be commented out or renamed; list every one you touched.
5. Do not change body text, figure paths or the bibliography style unless asked. Mention that `\graphicspath` now includes `Figures/` in addition to whatever the project used.
6. Compile with the project's engine. Iterate until zero errors. If a conflict cannot be resolved cleanly, revert that part and report it instead of forcing it.
7. Report every file added and every line changed in the preamble.

## Mode 3: add a reply-to-reviewers letter

1. Ensure `packages/reply_macros.tex` exists (copy from the source if needed) and that the main file inputs it and defines a clipboard: `\input{packages/reply_macros}` and `\newclipboard{output-<jobname>}` (use `output-main` when the main file is `main.tex`).
2. Copy `Reply_To_Reviewers.tex` from the source. Set its `\documentclass[<mainfile>]{subfiles}` and `\openclipboard{output-<jobname>}` to match. In a framework-based project set `\replytoreviewerstrue`; in any other project append `\newpage\onecolumn\subfile{Reply_To_Reviewers}` before `\end{document}` (or leave the letter standalone if the user prefers).
3. Fill the header (manuscript ID, title, journal) from what the user provides. If the user pastes the review, split it into `\editorsection` and `\reviewersection` blocks with one `\begin{point} ... \end{point}` per numbered comment and an empty `\replySingle{}` skeleton after each. Do not invent replies.
4. Compile the main file and, if requested, the letter standalone (compile main first so the clipboard file exists).

## Mode 4: update an EnICS-based project

1. Read the project's `\enicstemplateversion` (absent means pre-2026.09) and the source's. Say what changed by reading the source `CHANGELOG.md`.
2. Show the diff of the shared files before replacing them: `packages/*` (except a project-local `configuration.tex` edit, if any), `newcommands/*` except `this_glossary.tex`, `bibliography/abbreviations.bib`, `general_biblography.bib`, the staff `.bib` files, `Utilities/`, `Bios/BiosText.tex`, `AuxiliaryPages/*.tex` and logos for theses. If a shared file was customized locally, ask before overwriting it.
3. Never touch `main.tex`, `this_glossary.tex`, `this_bibliography.bib`, `abstract_hebrew.tex` or the user's chapters. If the new version renamed macros the project uses, patch the usages and list them.
4. Pre-2026.09 projects: if `Templates/AuxiliaryPages` or `Templates/Reply_To_Reviewers.tex` are referenced, either keep those paths working or move the files to the new locations and fix the references.
5. Compile, then report.

## Reporting and safety

- Never commit or push; the author decides when.
- Never delete something you have not verified is unreferenced (grep for its name first).
- If the build cannot be verified (no TeX installation), say so explicitly rather than claiming success.
