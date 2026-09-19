# EnICS Templates

LaTeX starting point for everything written at EnICS Labs (Bar-Ilan University): IEEE and ACM papers, MSc and PhD theses, research proposals and ISF grant proposals. One project, one shared preamble, one house style.

Template version: see `\enicstemplateversion` in [packages/configuration.tex](packages/configuration.tex). Changes are listed in [CHANGELOG.md](CHANGELOG.md).

## Getting a copy of the template

Pick one:

1. **Copy the Overleaf project (easiest).** Open [the template project](https://www.overleaf.com/read/wnrqnpmsdtyq#665a48), then *Menu, Copy Project*, and give the copy a meaningful name.
2. **Import from GitHub (preferred if you use git).** On your Overleaf dashboard: *New Project, Import from GitHub*, pick `EnICS-Templates`, then *Menu, Copy Project* to get your own working copy. You need a GitHub account linked to Overleaf; the GitHub sync feature requires an Overleaf premium plan (free for IEEE members). Email adam.teman@biu.ac.il with your GitHub username to be added.
3. **Clone from GitHub** (`https://github.com/enics-labs/EnICS-Templates`) and upload or push it to Overleaf yourself.

Never work inside the template project itself. Always copy it first. If you want the latest version later, delete your imported copy and import again before copying.

## Starting your manuscript

The whole body of your manuscript lives in `main.tex` in the root of the project. The Templates folder holds one ready-made `main.tex` per document type:

| Template | Use it for | Overleaf compiler |
|---|---|---|
| `IEEE_Journal.tex` | IEEE Transactions papers (with biographies and a reply-to-reviewers letter) | pdfLaTeX |
| `IEEE_Conference.tex` | IEEE conference papers | pdfLaTeX |
| `ACM_Journal.tex` | ACM journals (acmart class) | pdfLaTeX |
| `ACM_Conference.tex` | ACM conferences, currently set up for IEEE/ACM MICRO | pdfLaTeX |
| `MSc_Thesis.tex` | MSc thesis according to the BIU guidelines | LuaLaTeX |
| `PhD_Thesis.tex` | PhD thesis according to the BIU guidelines | LuaLaTeX |
| `Research_Proposal.tex` | MSc or PhD research proposal at BIU | LuaLaTeX |
| `ISF_Template.tex` | ISF Regular Program proposal | pdfLaTeX |

Three steps:

1. Delete the `main.tex` that came with the project (it is only a selector used to test the templates).
2. Drag the template you need from `Templates/` to the root of the project and rename it `main.tex`.
3. For theses and proposals, set *Menu, Compiler* to **LuaLaTeX**. That is what typesets the Hebrew pages.

Compile. You will see the template full of colored guidance text explaining what goes where. When you are ready to write, change `\guidetrue` to `\guidefalse` in the preamble of `main.tex` and every piece of guidance disappears from the PDF at once. You can then delete the `\guide{...}` lines and `guidance` blocks whenever you like, and delete the whole `Templates` folder.

If you use Claude Code, open the project and ask it to "start a new EnICS manuscript". It will do all of the above, ask for your title and authors, strip the guidance, remove the files you do not need and check that the project compiles. It can also apply the framework to an existing LaTeX project, add a reply-to-reviewers letter, or update an older project to the latest template version. The skill lives in `.claude/skills/enics-manuscript/`.

Two rules that save everyone time:

- Put your paper-specific acronyms and macros in `newcommands/this_glossary.tex`.
- Put your paper-specific references in `bibliography/this_bibliography.bib`.

Version control (*Menu, GitHub*) and Dropbox sync (*Menu, Dropbox*) are recommended.

## Theses and proposals: the front matter

BIU requires English and Hebrew title pages, a supervisor page and a Hebrew abstract. These are now plain LaTeX under `AuxiliaryPages/`:

- Fill in the title, author, advisor and date macros at the top of `main.tex` (in English and in Hebrew).
- Write your Hebrew abstract in `AuxiliaryPages/abstract_hebrew.tex`.
- For a PhD, edit the Hebrew table of contents in `AuxiliaryPages/front_page_hebrew_phd.tex`.
- Compile with LuaLaTeX. Hebrew is typeset with the David CLM font, which Overleaf has installed.

If you must compile with pdfLaTeX, the Hebrew pages fall back to the `..._example.pdf` files in `AuxiliaryPages/`. Edit the matching `.docx` files, export them to PDF with the same names, and you get the old workflow.

## Reply to reviewers

The journal templates end with `\subfile{Reply_To_Reviewers}`, controlled by `\replytoreviewerstrue` in `main.tex`. Write the letter in `Reply_To_Reviewers.tex` using `\editorsection`, `\reviewersection`, `point`, `\replySingle` and `\replyFull`. Text you wrap with `\Copy{name}{...}` in the manuscript can be quoted in the letter with `\Paste{name}`. To get the letter as a separate PDF, temporarily select `Reply_To_Reviewers.tex` as the Overleaf main document.

## A tour of the project

| Folder or file | What it is |
|---|---|
| `main.tex` | Your manuscript (in the template project: a selector that points at one of the templates) |
| `Templates/` | The eight templates listed above, and `templateText.tex`, which holds the guidance text they pull in with `\guide{tag}` |
| `packages/configuration.tex` | The version stamp, the `\ifguide` switch and one `\if...` flag per document type. All flags are false by default; each template turns on its own |
| `packages/basic_packages.sty` | Loads every package we use, some conditionally on those flags (margins, headers, Hebrew support, bibliography style, hyperref) |
| `packages/macros.tex` | House macros: `\figref`, `\secref`, `\tblref`, `\eqref`, colored text (`\red`, `\blue`), `\needref`, `\TBD`, `\orcidicon`, the abstract character counter |
| `packages/reply_macros.tex` | Macros for the reply-to-reviewers letter |
| `packages/sig-alternate.cls`, `packages/flushend.sty` | Used by the ACM conference (MICRO) template only |
| `newcommands/units.tex` | Units and symbols with siunitx (`\nm`, `\uW`, `\X`, ...) |
| `newcommands/general_glossary.tex`, `vlsi_glossary.tex`, `ai_glossary.tex` | Acronyms (glossaries package) for general, chip-design and AI terms, with shorthand macros (`\sota`, `\soc`, `\dnn`, ...) |
| `newcommands/enics_glossary.tex` | EnICS affiliations, IEEE membership macros, staff author macros with ORCIDs, funding sentences |
| `newcommands/this_glossary.tex` | Your own acronyms and macros |
| `bibliography/bibliography.tex` | Sets the bibliography style and loads all the `.bib` files below |
| `bibliography/abbreviations.bib` | Journal and conference names as BibTeX strings (`journal=JSSC`, `booktitle=ISCAS`), with impact factors |
| `bibliography/general_biblography.bib`, `<staff>_bibliography.bib` | Things we cite a lot, and each staff member's publications |
| `bibliography/this_bibliography.bib` | Your own references |
| `AuxiliaryPages/` | LaTeX front matter for theses and proposals (English and Hebrew), the BIU logos, and the legacy `.docx` files with example PDFs |
| `Reply_To_Reviewers.tex` | The reply-to-reviewers letter (journal templates) |
| `Bios/` | IEEE biographies and photos of EnICS staff, pulled in with `\ExecuteMetaData[Bios/BiosText]{Name}` |
| `Figures/` | Put your figures here. Also holds `matlab_figure.m` and `python_figure.py`, templates for article-quality plots |
| `Utilities/latexmkrc` | Copy to the root to embed all fonts (IEEE PDF eXpress compliance) |
| `Utilities/ExtractPagesFromPDF.tex` | Extract a page range from a PDF (e.g., only the bibliography of a proposal) |
| `Utilities/build_all.sh` | Compiles every template in a scratch copy; used by the GitHub Actions workflow and before releases |

## For maintainers

- Work in Overleaf; push to GitHub when a version is ready. Bump `\enicstemplateversion` in `packages/configuration.tex` and add a line to `CHANGELOG.md`.
- Before pushing, run `bash Utilities/build_all.sh -n` locally (needs latexmk, lualatex, texcount and pygments), or rely on the GitHub Actions workflow in `.github/workflows/`, which builds all templates on every push.
- Guidance text belongs in `Templates/templateText.tex` (as a tagged block used with `\guide{tag}`), in a `\guidenote{...}`, or inside a `guidance` environment. Never as plain text in a template.
- Anything the templates need at compile time must live outside `Templates/`, because students delete that folder.

Questions, suggestions, or want to become a collaborator? Email adam.teman@biu.ac.il.
