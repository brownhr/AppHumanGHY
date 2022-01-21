# Appalachian Human Geography Paper

WIP paper by S. Ryan, J. Platt, and H. Brown

More details to come later!

---

## Getting Set Up

Let's try and write as much of this through GitHub and Markdown as we can... While Zotero and other software works fine with Google Docs, it's a lot easier to have formats and citations be consistent if we do it this way. Of course, I'm happy to bring things into Markdown if need be, but it's a pretty good skill to have to be able to do this!

Anyways, here's some info/resources to help us stay on the same page!

Software:

- Git & GitHub Desktop
  - Obviously, we all need GitHub accounts to edit the repo, but having things on our desktop allows us to make commits and save our progress a lot more easily.
- Visual Studio Code
  - Not essential, but if you have the right extensions it can be a wonderful text editor for scientific writing. I'll help everyone get set up with this, but for reference, I haven't opened MS Word in over a year. There's a bit of a learning curve, of course, but it makes things very easy to collaborate on a paper.
  - Also, having things in Markdown rather than MS Word makes it *significantly* easier to manage conflicts; i.e. if more than one person is editing the same file at a time.
- R Studio
  - R Studio also has Git support, so if we have any sort of datasets or analyses that we want to include, this makes it a lot easier to manage than everyone working off of their own copy.
  - R Markdown / Bookdown: excellent way to convert a .rmd to a .pdf, with very crisp formatting
- Zotero: Citation manager :)
  - Better Bibtex: Makes setting up citations more convenient through Zotero; directions to install [here](https://retorque.re/zotero-better-bibtex/installation/)
As far as getting set up with how to actually write using Markdown and GitHub, I'm happy to help get everyone on the same page. GitHub is great, not only for having incremental file management (backups!) but also because of the Issues feature; basically, a built-in todo list of what we need to change, add, etc., which can be embedded directly into our document, sort of like comments on a Google Doc.

## File Structure & Markdown

So far, there's a few files in the Repo. Don't worry about them yet, I was just playing around with Markdown to get things working with Zotero.

**Important Files / Extensions:**

- `bibliography.bib`: This is our bibliography, pulled directly from Zotero. Whenever we add a new citation, this file will (should) automatically update. Adding citations within Markdown (specifically, R Markdown) isn't too complicated, once you get the hang of it. Basically, each citation has a "Citation Key" which looks like a Twitter handle e.g. `@cresswell_geographic_2013`
- `csl/aag.csl`: This file tells R Markdown to use the AAG style, but if a journal requests something else (e.g. Chicago author/date) it's easy enough to just add that file and change the .rmd header.
- `.rmd`: R Markdown, basically a version of Markdown that is compiled through R (whether in R Studio or VS Code). There's lots of support for adding figures, tables, images, etc. that are generated directly through R (no more screenshotting and pasting into a Word doc!)
