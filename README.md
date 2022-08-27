# quarto_titlepages <a href="https://github.com/nmfs-opensci/quarto_titlepages"><img src="https://github.com/nmfs-opensci.png" align="right" width="120"/></a>

[Try it out on RStudio Cloud](https://rstudio.cloud/content/4370280) --- [Read documentation](https://nmfs-opensci.github.io/quarto_titlepages/)

This is a [Quarto](https://quarto.org/) extension to help you make custom title pages and cover pages for PDF output. 

<a href="media/bg-image.png"><img src="media/bg-image.png" width="200"/></a>


## Installing the extension

```bash
quarto use template nmfs-opensci/quarto-titlepages
```

This will install the extension and create an example qmd file and bibliography that you can use as a starting place. *Note, this example qmd is minimilistic; see the `article.qmd` files in each title page folder in `_extensions` to see fuller examples.

## Installation for an existing document

You may also use this format with an existing Quarto project or document.
From the quarto project or document directory, run the following command to install the extension in a `_extensions` folder in your project:

```bash
quarto install extension nmfs-opensci/quarto-titlepages
```

## Usage

After installing the extension, you will find folders for each of the title and cover page examples in the `_extensions` folder, e.g. `vline` or `bg-image`. The folder contains the necessary `.tex` templates, any needed images, and a `article.qmd` file with a full YAML example. You can render the example `article.qmd` directly in the folder to render an example with the specified title or cover page example.

You also run using the format that each extension provides, e.g. `vline-pdf` or `bg-image-pdf`. See the documentation for all options.

For example:

```bash
quarto render template.qmd --to great-wave-pdf
```

or in your document yaml add

```yaml
format: great-wave-pdf
```

## Customizing

Find one of the templates (e.g. `vline` or `bg-image`), copy its folder, and edit `_titlepage.tex` and/or `_cover.tex`.

------

This work is uses the [Quarto](https://quarto.org/), [citation](https://github.com/quarto-dev/quarto-cli/blob/main/CITATION.cff). The default document classes for Quarto are scrbook and scrartcl. This repo also includes a copy of the Springer [svmono](https://www.springernature.com/gp/authors/campaigns/latex-author-support) document class, CRC/Chapman & Hall krantz document class, and the Elsevier elsarticle document class.
