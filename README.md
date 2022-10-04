[![github](https://img.shields.io/github/v/release/nmfs-opensci/quarto_titlepages?color=brightgreen&label=GitHub)](https://github.com/nmfs-opensci/quarto_titlepages/releases/latest)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7131047.svg)](https://doi.org/10.5281/zenodo.7131047)

# quarto_titlepages <a href="https://github.com/nmfs-opensci/quarto_titlepages"><img src="https://github.com/nmfs-opensci.png" align="right" width="120"/></a>

[Read the documentation](https://nmfs-opensci.github.io/quarto_titlepages/)

VERSION 3.0 RELEASED

A Quarto extension for adding a custom title page or book cover to your PDF output using the information in the YAML in your Quarto doc, i.e. from the `xyz.qmd` for an single doc and from `index.qmd` for a [Quarto](https://quarto.org/) book. 

<img src="./img/example.png" width="200"/>

## Install the extension

```bash
quarto use template nmfs-opensci/quarto_titlepages
```

This will install the extension plus all the demo files. Essentially, you will be cloning the repo into a new folder and you will be asked at installation for the name of the (empty) folder/directory that you want to install into.

## Install for an existing document

You may also use this format with an existing Quarto project or document. This will install only the files in the `_extension` folder and will not install the files above that (the demo files).

From the quarto project or document directory, run the following command:

```bash
quarto install extension nmfs-opensci/quarto_titlepages
```

## Usage

In your document yaml add the format and a titlepage theme.

```yaml
format: 
  titlepage-pdf:
    coverpage: great-wave
    titlepage: bg-image
```

Then render the document. See the documentation for the possible themes.

## Customizing

All aspects of the title and cover pages can be customized and static pages (e.g. copyright) can be added after the title page. [Read the documentation](https://nmfs-opensci.github.io/quarto_titlepages/). tldr; In your yaml, you pass in `titlepage-theme:` or `coverpage-theme:` with variables for things like font, fontstyle, position of elements, colors, background images, etc.

## LaTeX users

If you have a title page and/or cover page, that you want to use directly. You might want to look at [quarto_titlepages_v1](https://github.com/nmfs-opensci/quarto_titlepages). This shows you how to create your own Pandoc templates so you can get control of the title page in your tex files. Alternatively, if you have a static title or cover page, see the documentation chapter on using static tex files in your frontmatter.

------
This work is uses [Quarto](https://quarto.org/), [citation](https://github.com/quarto-dev/quarto-cli/blob/main/CITATION.cff). The default document classes for Quarto are scrbook and scrartcl. This repo also includes a copy of the Springer [svmono](https://www.springernature.com/gp/authors/campaigns/latex-author-support) document class, CRC/Chapman & Hall krantz document class, and the Elsevier elsarticle document class. The tex templates were written by [Eli Holmes](https://github.com/eeholmes) and the lua filter along with changes to the Pandoc templates to allow themes was written by [Mickaël Canouil](https://github.com/mcanouil).
