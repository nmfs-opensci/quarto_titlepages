# quarto_titlepages <a href="https://github.com/nmfs-opensci/quarto_titlepages"><img src="https://github.com/nmfs-opensci.png" align="right" width="120"/></a>

[Try it out on RStudio Cloud](https://rstudio.cloud/content/4370280) --- [Read the documentation](https://nmfs-opensci.github.io/quarto_titlepages/)

This repo includes a Quarto extension and templates for making a custom title page or book cover using the information in the YAML (from the `xyz.qmd` for an single doc and from `index.qmd` for a [Quarto](https://quarto.org/) book). 

<img src="./img/example.png" width="200"/>


## Install the extension

```bash
quarto use template nmfs-opensci/quarto_titlepages
```

This will install the extension in the `_extension` folder plus all the demo files. Essentially, you will be cloning the repo into a new folder and you will be asked at installation for the name of the (empty) folder/directory that you want to install into.

## Install for an existing document

You may also use this format with an existing Quarto project or document. This will install only the files in the `_extension` folder and will not install the files above that (the demo files).

From the quarto project or document directory, run the following command:

```bash
quarto install extension nmfs-opensci/quarto_titlepages
```

## Usage

In your document yaml add the format and a titlepage theme.

```yaml
format: titlepage-pdf
titlepage: great-wave
```

Then render the document. See the documentation for the possible themes.

## Customizing

In the `examples` folder of the repo, you will find a dynamic and static example of using Pandoc templates when rendering a pdf. Read the documentation to get oriented or skim the code and it should be apparent how it works. Start with the static example.

If you want to customize one of the title page themes, you will find tex files for each of the title and cover page examples in the `_extensions` folder, *e.g.*, `_vline_titlepage.tex`.

**Help? What's all the weird code in the `_titlepage.tex` files?** If you are looking at one of the dynamic examples, this file is a combo of Pandoc template code and LaTeX. Try looking at one of the static examples, if you want to see pure LaTeX code. Note in that case, your YAML info (like author, title) will be ignored and the info in the `_titlepage.tex` file is what makes the title page.

**Can I just edit the files in the `_extensions` folder?** Yes...but if you are not familiar with writing Quarto extensions, this might be frustrating. You have to declare all files you use in the `_extension.yml` and if you add new files/themes, you need to edit the `theme.lua` filter plus `before-body.tex`.

See the documentation for more information on customizing.

------
This work is uses [Quarto](https://quarto.org/), [citation](https://github.com/quarto-dev/quarto-cli/blob/main/CITATION.cff). The default document classes for Quarto are scrbook and scrartcl. This repo also includes a copy of the Springer [svmono](https://www.springernature.com/gp/authors/campaigns/latex-author-support) document class, CRC/Chapman & Hall krantz document class, and the Elsevier elsarticle document class. The tex templates were written by [Eli Holmes](https://github.com/eeholmes) and the lua filter along with changes to the Pandoc templates to allow themes was written by [Mickaël Canouil](https://github.com/mcanouil).
