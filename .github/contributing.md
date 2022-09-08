# Contributing

Contribution of more templates welcome! Just post a pull request.

## Adding a new template.

1. Make a new folder in `titlepages`.
2. Add your files there.

For quarto_titlepages, I want to stick to just 4 files: `_titlepage.tex`, `before-body.tex`, `title.tex` and `in-header.tex`. See the [LaTeX structure](https://nmfs-opensci.github.io/quarto_titlepages/06-latex.html) chapter for where these end up in the LaTeX document.

The YAML should have this, but leave off `title.tex` if it is not used.

```
    template-partials:
      - "before-body.tex"
      - "title.tex"
      - "_titlepage.tex" 
    include-in-header: 
      - "in-header.tex"
```

## Extra stuff

Add images to a `images` folder in your `titlepages` folder.