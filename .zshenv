rmd() { Rscript -e "knitr::opts_chunk$set(echo = TRUE, fig.align="center"); rmarkdown::render('$1')"; }
