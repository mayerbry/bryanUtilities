# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   https://r-pkgs.org
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

#' wrapper to install git from network drives
#'
#' @param pdata_path string path to network drive
#' @param ... arguments for remotes::install_git
#'
#' @return
#' @export
install_git_wd = function(pdata_path, ...){
  stopifnot(file.exists(pdata_path))
  current_dir = getwd()
  setwd(dirname(pdata_path))
  remotes::install_git(basename(pdata_path), ...)
  setwd(current_dir)
  invisible()
}
