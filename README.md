# EnICS-Templates
Template for creating Overleaf project


To start an Overleaf project based on this template, you have three options:
1) (easiest) Make a copy of the project
2) (preferred) Adding the project to your github.com account.
3) (alternative option) Cloning the project from https://github.com/enics-labs/EnICS-Templates and uploading it to your Overleaf account.

For option 1, you will need to follow these steps:
1) Go to the project at [https://www.overleaf.com/read/wnrqnpmsdtyq#665a48](https://www.overleaf.com/read/wnrqnpmsdtyq#665a48)
2) In Overleaf, go to "Menu"-->"Copy Project"
3) Give the project a new name (preferably with a meaning)
4) Start working on the new project!

For option 2, you will need to follow these steps:

## Preliminaries:
1) You need to have a github.com account 
2) You have to have a professional overleaf account, which you are eligible for free if you are an IEEE Member.

## First Time Only Procedure:
1) Send Prof. Adam Teman an email with your github username (adam.teman@biu.ac.il)
2) You will then receive an invitation to the "EnICS Templates" project on github
3) Login to github and accept the invitation
4) On your Overleaf dashboard, click on *MENU-->New Project-->Import from GitHub*
5) You will be asked to *link your github account* with your Overleaf account. Follow the instructions.

## Every time you want to start a new Overleaf project:
1) On your Overleaf dashboard, click on *MENU-->New Project-->Import from GitHub*
2) Select "EnICS Templates". You will now have a project called "EnICS Templates" in your Overleaf project list.
3) Go into the "EnICS Templates" project and click *MENU-->Copy Project*
4) Give your project a new name and start writing!

Note that you are not supposed to work directly on the EnICS Template project, which is a public repository. That is why we make a copy. 
As a new user, you will be added as a "reader"to the project, and therefore cannot commit new changes. 
If you become a power user, I will make you a collaborator, so you can add new features to the template.
Also note that you will not be able to pull recent changes from the repo, since Overleaf does a "merge and commit", which requires write permissions. 
Therefore, if you are starting a new project and want the latest version of the templates, delete the "EnICS Template" project from your Overleaf dashboard and import it again before making a copy.

Please email adam.teman@biu.ac.il with any comments or suggestions and/or if you want to become a collaborator!

# How to Use the Template?

## Choosing a Template
There are templates for different types of submissions under the Templates folder
** What Types of Templates are Included? **
1. *IEEE_Journal.tex*:  A template for creating Journal papers according to the IEEE Transactions guidelines.
2. *IEEE_Conference.tex: A template for creating conference papers according to many IEEE Conferences.
3. *ACM_Journal.tex: A template for creating Journal papers according to ACM formatting.
4. *ACM_Conference.tex: A template for creating conference papers according to ACM formatting (made particularly for IEEE Micro).
5. *MSC_Thesis.tex*: A template for writing MSc Theses at BIU.
6. *PhD_Thesis.tex*: A template for writing PhD Theses at BIU.
7. *Research_Proposal.tex*: A template for writing MSc or PhD Research Proposals at BIU.
8. *ISF_Template.tex*: A basic template for starting to write an ISF Regular Program proposal.
9. *Reply_To_Reviwers.tex*: A template for creating a rebuttal letter. To be used along with the *IEEE_Journal* template, when submitting a revision.

## Starting your own project
1. As explained before, first **Copy the Project** to a new project, by using *Menu-->Copy Project*
2. Next, go to the Templates folder and move the template that you need to the root directory. You could also uncomment the relevant include command in main.tex, but I recommend moving your file to the root directory.
3. Update the default file to compile under *Menu-->Main Document*
4. Delete or comment out the \ExecuteMetaData commands to get rid of default text. **Do not edit your paper inside the templateText.tex file!**
5. I recommend using github for version control (*Menu-->github*) and to use Dropbox integration for easy file management (*Menu-->Dropbox*)

# A Tour of the Template folders and files
The Template repository has several folders with files for your usage. You can modify all these files and if you have suggestions to add for everyone, please tell a developer (e.g., Prof. Adam Teman) about it:
1. **Templates**: Where you'll find all the template files, discussed above. In addition this folder includes:
    a. Word files for creating PDFs to be included in research proposals and theses (front matter and abstracts)
    b. **templateText.tex**: A file for decoupling the text in the template files from the files themselves (to make the template files cleaner).
2. **common**: This has files needed by pretty much everyone (not EnICS specific)
    a. **configuration.tex**: This is a file that defines LaTeX variables for each template to enable specific configurations. All variables are **false** by default and each template turns on the configuration relevant to it.
    b. **basic_packages.sty**: This is the class that loads the packages you will need to compile your file. Certain packages are conditionally loaded based on the template configuration.
    c. **general_glossary.tex**: All kinds of acronyms that are not VLSI specific.
    d. **units.tex**: Shorthand for writing out units (with the siunitx package) and symbols.
    e. **macros.tex**: Small macros that are very useful.
    f. **reply_macros**: Macros to be used with the *Reply_To_Reviewers* template.
    g. Other files that are needed by specific templates: **sig-alternate.cls** and **flushend.sty** (used by the *ACM_Conference* template).
3. **EnICS**: Files that are specific to EnICS and not for a non-BIU user
    a. **enics_glossary.tex**: Shorthand for things that are useful for EnICS users.
    b. **vlsi_glossary.tex**: Common acronyms found in the fields of Chip Design.
    c. Template pages for front page matter and Hebrew abstracts for inclusion in proposals and theses.
4. **Figures**: The folder to store your figures in. In addition, this folder includes:
    a. **matlab_figure.m**: A template script for creating nice figures in Matlab.
    b. **python_figure.m**: A template script for creating nice figures in Python.
5. **bibliography**: A folder for storing *bibtex* files for the project and well formatted EnICS publication bibliographical entries. In addition, this folder contains:
    a. **abbreviations.bib**: Bibtex variables for describing popular conferences and journals, including shortened versions and versions with the impact factor stated.
    b. **this_bibliography.bib**: Bibtex file for adding new bibliographic entries, specific to this project.
6. **Bios**: A folder for creating biographical text and pictures for inclusion in Journal publications
7. **Utilities**: A folder that includes useful tools and Utilities (you will need to move these to the root directory for them to work):
    a. **ExtractPagesFromPDF.tex**: A template to cut certain pages out of a longer PDF. For example, if you need to extract only the bibliography from a full proposal or only the reply to reviewers letter from a revised manuscript.
    b. **latexmkrc**: A script for ensuring that your PDF passes IEEE Camera Ready compliance.    



