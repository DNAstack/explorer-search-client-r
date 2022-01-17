# explorer-search-client-r
A DNAstack Explorer search client for R.  

Tested with R version 4.1.1

These instructions install the library from github, and require that libgit2 be installed on your system.  This can be installed using:

- MacOS: `brew install libgit2`
- Ubuntu or Debian Linux: `sudo apt-get install libgit2-dev`
- Fedora Linux: `sudo yum install libgit2-devel`

To use, start up R and type:
```
install.packages("devtools")
devtools::install_github("DNAstack/explorer-search-client-r")
```

Type `??explorer.search` for help.  

