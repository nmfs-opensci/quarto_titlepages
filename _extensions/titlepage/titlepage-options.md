Options

```
    titlepage: vline, academic, classic, box, thesis 
    titlepage-logo: "img/logo.png" # filename
    titlepage-bg-image: "img/ringed-seal.png"
    titlepage-header: "The Publisher" # text
    titlepage-footer: | # text
      University Technical Series\
      Open Source Publication for All\
      Amtmandens Allé 15\
      6950 Rindum Ringkøbing-Skjern\
      DENMARK\
      December 2025
    titlepage-theme: 
      elements: ["\\titleblock", "\\authorblock", "\\affiliationblock", "\\logoblock", "\\vfill", "\\footerblock"] # list of things to include
      page-html-color: "c4c4c4" # html color
      page-color: green # use either html color xcolors
      page-text-align: left, right, center
      page-fontfamily: "Palatino"
      page-fontsize: "Palatino"
      title-style: "plain"
      title-fontfamily: "Palatino"
      title-fontstyle: "\\Huge\\bfseries"
      title-align: left
      title-space-after: 1in
      subtitle-fontstyle: "\\large"
      author-style: "superscript"
      author-fontfamily: "Palatino"
      author-fontstyle: "\\large"
      author-align: left
      author-space-after: 1in
      affiliation-style: "numberedlist"
      affiliation-fontfamily: "Palatino"
      affiliation-fontstyle: "\\large"
      affiliation-align: left
      affiliation-space-after: 1in
      footer-style: "plain"
      footer-fontfamily: "Palatino"
      footer-fontstyle: "\\large"
      footer-align: left
      footer-space-after: 1in
      header-style: "plain"
      header-fontfamily: "Palatino"
      header-fontstyle: "\\large"
      header-align: left
      header-space-after: 1in
      logo-size: 0.25
      logo-space-after: 1in
      bg-image-size: 0.25
      bg-image-location: "URCorner"
      vrule-width: 20pt
      vrule-color: "blue"
      vrule-space-after: 10pt
```

## title-box

```
    titlepage: title-box 
    titlepage-theme: 
      elements: ["\\titleblock", "\\authorblock", "\\affiliationblock", "\\vfill", "\\logoblock", "\\footerblock"]
      page-text-align: left
      title-style: "plain"
      title-fontstyle: "\\large\\bfseries"
      title-space-after: "4\\baselineskip""
      subtitle-fontstyle: "\\large\\textit"
      author-style: "superscript-with-and"
      author-fontstyle: "\\large"
      author-space-after: "2\\baselineskip"
      affiliation-style: "numberedlist-with-correspondence"
      affiliation-space-after: 0in
      footer-style: "plain"
      footer-fontstyle: "\\large"
      footer-space-after: 0in
      logo-size: 0.25
      logo-space-after: "0.1\\textheight"
      vrule-width: 1pt
      vrule-color: "black"
      vrule-space: "0.05\\textwidth"
      vrule-align: "left", "right", "leftright"
      colorbox-color: cyan
```

## vline

```
    titlepage: vline 
    titlepage-theme: 
      elements: ["\\titleblock", "\\authorblock", "\\affiliationblock", "\\vfill", "\\logoblock", "\\footerblock"]
      page-text-align: left
      title-style: "plain"
      title-fontstyle: "\\large\\bfseries"
      title-space-after: "4\\baselineskip""
      subtitle-fontstyle: "\\large\\textit"
      author-style: "superscript-with-and"
      author-fontstyle: "\\large"
      author-space-after: "2\\baselineskip"
      affiliation-style: "numberedlist-with-correspondence"
      affiliation-space-after: 0in
      footer-style: "plain"
      footer-fontstyle: "\\large"
      footer-space-after: 0in
      logo-size: 0.25
      logo-space-after: "0.1\\textheight"
      vrule-width: 1pt
      vrule-color: "black"
      vrule-space-after: "0.05\\textwidth"
```

vrule-text
```
      vrule-width: 25pt
      vrule-text: "Set in titlepage-theme: vrule-text"
      vrule-text-color: white
```