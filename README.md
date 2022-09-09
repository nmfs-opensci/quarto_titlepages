# quarto_titlepages <a href="https://github.com/nmfs-opensci/quarto_titlepages"><img src="https://github.com/nmfs-opensci.png" align="right" width="120"/></a>

[Try it out on RStudio Cloud](https://rstudio.cloud/content/4370280) --- [Read documentation](https://nmfs-opensci.github.io/quarto_titlepages/)

This is a [Quarto](https://quarto.org/) extension to help you make custom title pages and cover pages for PDF output.

<a href="img/bg-image.png"><img src="img/example.png" width="200"/></a>

## Install the extension

```bash
quarto use template nmfs-opensci/quarto-titlepages@extension
```

This will install the extension and create an example qmd file and bibliography that you can use as a starting place. Note, it will ask for the directory name and will install in that (empty) directory.

## Installation for an existing document

You may also use this format with an existing Quarto project or document.
From the quarto project or document directory, run the following command to install the extension in a `_extensions` folder in your project:

```bash
quarto install extension nmfs-opensci/quarto-titlepages@extension
```

## Usage

After installing the extension, you will find tex files for each of the title and cover page examples in the `_extensions` folder, *e.g.*, `_vline_titlepage.tex`.
The folder contains the necessary `.tex` templates and a `theme.lua` filter that sets up the metadata so that the pandoc template in `before-body.tex` chooses the right title page theme and cover based on `titlepage: ` in the YAML.

In your document yaml add the format and a titlepage theme.

```yaml
format: titlepage-pdf
titlepage: great-wave
```

Then render the document.

## Customizing

Find one of the templates (*e.g.*, `vline` or `bg-image`) and edit its `_titlepage.tex` and/or `_cover.tex` files.

------

This work is uses [Quarto](https://quarto.org/), [citation](https://github.com/quarto-dev/quarto-cli/blob/main/CITATION.cff).
The default document classes for Quarto are scrbook and scrartcl.
This repo also includes a copy of the Springer [svmono](https://www.springernature.com/gp/authors/campaigns/latex-author-support) document class, CRC/Chapman & Hall krantz document class, and the Elsevier elsarticle document class. The tex templates were written by [Eli Holmes](https://github.com/eeholmes) and the lua filter to allow themes was written by [Mickaël Canouil](https://github.com/mcanouil).
