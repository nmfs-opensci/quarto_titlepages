[![github](https://img.shields.io/github/v/release/nmfs-opensci/quarto_titlepages?color=brightgreen&label=GitHub)](https://github.com/nmfs-opensci/quarto_titlepages/releases/latest)
[![DOI](https://zenodo.org/badge/521413662.svg)](https://zenodo.org/badge/latestdoi/521413662) [![](https://img.shields.io/badge/Open%20In-RStudio%20Cloud-green)](https://rstudio.cloud/content/4891671) <-- *Try it out!*

# quarto_titlepages <a href="https://github.com/nmfs-opensci/quarto_titlepages"><img src="https://github.com/nmfs-opensci.png" align="right" width="120"/></a>

[Read the documentation](https://nmfs-opensci.github.io/quarto_titlepages/)
 

A Quarto extension for adding a custom title page or book cover to your PDF output using the information in the YAML in your Quarto doc, i.e. from the `xyz.qmd` for an single doc and from `index.qmd` for a [Quarto](https://quarto.org/) book. 

<img src="./img/example.png" width="200"/>

## Install the extension

```bash
quarto use template nmfs-opensci/quarto_titlepages
```

This will install the extension plus all the example files. Essentially, you will be cloning the repo into a new folder and you will be asked at installation for the name of the (empty) folder/directory that you want to install into.

## Install or update for an existing document

You may also use this format with an existing Quarto project or document. This will install only the files in the `_extension` folder and will not install the files above that (the demo files). This is also how to update the extension if there have been changes.

From the quarto project or document directory, run the following command:

```bash
quarto install extension nmfs-opensci/quarto_titlepages
```

## Usage

In your document yaml add the format and a titlepage theme.

```yaml
format: 
  titlepage-pdf:
    titlepage: bg-image
```

Then render the document using either the 'render' button in your IDE or from the terminal with
```
quarto render article.qmd
````
Note if you add `--to` to the command, use `--to titlepage-pdf` not `--to pdf`.

See the documentation for the possible themes.

### Example files

There are two example file. `example_1.qmd` shows an example with only a titlepage. `example_2.qmd` has a cover page, copyright page, title page and dedication page. The copyright and dedication pages are in the `tex` folder. This example will not run if you don't have those files. The examples also use images in the `img` folder. You will need those files or replace them with your own.

## Customizing

All aspects of the title and cover pages can be customized and static pages (e.g. copyright) can be added after the title page. [Read the documentation](https://nmfs-opensci.github.io/quarto_titlepages/). 

tldr; In your yaml, you pass in `titlepage-theme:` or `coverpage-theme:` with variables for things like font, fontstyle, position of elements, colors, background images, etc.

## Getting rid of the QTDublinIrish.otf file

This is coming from the extension for the cover page demos. Find the `_extension.yml` file in the `_extensions` folder for the `titlepage` extension. Delete these lines
```
      format-resources:
        - "fonts/qualitype/opentype/QTDublinIrish.otf"
```

## LaTeX users

If you have a title page and/or cover page, that you want to use directly. You might want to look at [quarto_titlepages_v1](https://github.com/nmfs-opensci/quarto_titlepages). This shows you how to create your own Pandoc templates so you can get control of the title page in your tex files. Alternatively, if you have a static title or cover page, see the documentation chapter on using static tex files in your frontmatter.

------
This work is uses [Quarto](https://quarto.org/), [citation](https://github.com/quarto-dev/quarto-cli/blob/main/CITATION.cff). The default document classes for Quarto are scrbook and scrartcl. This repo also includes a copy of the Springer [svmono](https://www.springernature.com/gp/authors/campaigns/latex-author-support) document class, CRC/Chapman & Hall krantz document class, and the Elsevier elsarticle document class. The tex templates were written by [Eli Holmes](https://github.com/eeholmes) and the lua filter along with changes to the Pandoc templates to allow themes was written by [Mickaël Canouil](https://github.com/mcanouil).

<hr>

## Disclaimer

This repository is a scientific product and is not official communication of the National Oceanic and Atmospheric Administration, or the United States Department of Commerce. All NOAA GitHub project content is provided on an ‘as is’ basis and the user assumes responsibility for its use. Any claims against the Department of Commerce or Department of Commerce bureaus stemming from the use of this GitHub project will be governed by all applicable Federal law. Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by the Department of Commerce. The Department of Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used in any manner to imply endorsement of any commercial product or activity by DOC or the United States Government.

## License addendum

This content was created by U.S. Government employees as part of their official duties.  This content is not subject to copyright in the United States (17 U.S.C. §105) and is in the public domain within the United States of America. Additionally, copyright is waived worldwide through the CC0 1.0 Universal public domain dedication.
