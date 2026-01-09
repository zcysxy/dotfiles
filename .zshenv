rmd() { Rscript -e "knitr::opts_chunk$set(echo = TRUE, fig.align="center"); rmarkdown::render('$1')"; }
. "$HOME/Library/Application Support/cargo/env"

