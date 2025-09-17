## Common support code for vignettes. This will not be echoed to the
## user, so be sure not to define functions here that they might want
## to use.
##
## Typically, include this in the Rmd within a block like:
##
## ```{r, include = FALSE}
## ...
## ```
dir_tree <- function(path = ".", sub = ".", all = FALSE,
                     ignore_outpack = TRUE, ...) {
  if (all && ignore_outpack) {
    regexp <- "^\\.outpack"
    invert <- TRUE
  } else {
    regexp <- NULL
    invert <- FALSE
  }
  withr::with_dir(
    path,
    fs::dir_tree(sub, all = all, regexp = regexp, invert = invert, ...))
}

lang_output <- function(x, lang) {
  writeLines(c(sprintf("```%s", lang), x, "```"))
}
r_output <- function(x) {
  lang_output(x, "r")
}
yaml_output <- function(x) {
  lang_output(x, "yaml")
}
json_output <- function(x) {
  lang_output(x, "json")
}
plain_output <- function(x) {
  lang_output(x, "plain")
}
orderly_file <- function(...) {
  system.file(..., package = "orderly", mustWork = TRUE)
}

inline <- function(x) {
  sprintf("`%s`", format(x))
}

knitr::opts_chunk$set(
  collapse = TRUE)
