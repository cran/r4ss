## ---- echo = FALSE, message = FALSE--------------------------------------
knitr::opts_chunk$set(collapse = T, comment = "#>")
options(tibble.print_min = 4L, tibble.print_max = 4L)
library(r4ss)

## ---- install-and-load, eval=FALSE---------------------------------------
#  # install.packages("devtools") # if needed
#  devtools::install_github("r4ss/r4ss")
#  
#  # If you would like the vignettes (so far there's just this one):
#  devtools::install_github("r4ss/r4ss", build_vignettes = TRUE)

## ---- load-package, eval=FALSE-------------------------------------------
#  library("r4ss")

## ---- help, eval=FALSE---------------------------------------------------
#  ?r4ss
#  help(package = "r4ss")
#  browseVignettes("r4ss")

## ---- install-older-version, eval=FALSE----------------------------------
#  devtools::install_github("r4ss/r4ss", ref="1.26.0") # install r4ss version 1.26.0
#  

## ---- eval=FALSE, echo=TRUE, message=FALSE-------------------------------
#  # it's useful to create a variable for the directory with the model output
#  mydir <- file.path(path.package("r4ss"), "extdata/simple_3.30")
#  
#  # read the model output and print some diagnostic messages
#  replist <- SS_output(dir = mydir, verbose=TRUE, printstats=TRUE)
#  
#  # plots the results
#  SS_plots(replist)

