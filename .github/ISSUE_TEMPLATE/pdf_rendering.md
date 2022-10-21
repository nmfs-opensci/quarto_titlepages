---
name: PDF rendering problems
about: Problems getting pdf output at all
title: ''
labels: ''
assignees: ''

---

quarto_titlepages relies on features of Quarto that are new. To help us out, 

* Please run `quarto --version` from a terminal (shell) and report the Quarto version you are using. 
* Tell us what operating system you are on.

Having trouble rendering to PDF? Like it just doesn't work at all, not like it works but looks janky. In order to help, we some info:

* How you are rendering Quarto docs (RStudio, VS Code, command line, etc)?
* What TeX and version you are using? Run `tex --version` in a terminal (or shell).

### Description

*describe the problem*

*if applicable, add the steps to replicate*

## Some tips that might help you out

* `tex --version` *says command not found.* Try installing tinytex and see if that solves your problems. [Installation instructions](https://quarto.org/docs/output-formats/pdf-basics.html).

* Are you using tinytex? Note tinytex is a version of TeXLive so you won't see it when you get the tex version. 
    * *I don't know and I don't know how to find out.* Ok.
    * Are you on a linux machine with Debian and Ubuntu? If you are on a virtual machine machine, then probably yes. Try typing `cat /etc/os-release` in a terminal (shell). Debian comes with an out of date version of TeXLive, which is going to cause you headaches. If you completely uninstall that TeX installation and install tinytex, things work better.

* I am on Windows or Mac. Did you install LaTeX, like MikTeX or MacTeX? 
    * No I didn't. [Try installing tinytex](https://quarto.org/docs/output-formats/pdf-basics.html).
    * Yes I did. Oy. Quarto seems to work best with tinytex having to do with auto-updating of packages. You can [try installing tinytex](https://quarto.org/docs/output-formats/pdf-basics.html) and Quarto might find that. You might have to edit your system path. Editing your path might cause you problems for your non-Quarto TeX workflow though.

