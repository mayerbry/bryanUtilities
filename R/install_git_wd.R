#' wrapper to install git from network drives
#'
#' @param pdata_path string path to network drive
#' @param ... arguments for remotes::install_git
#'
#' @return invisible
#' @export
install_git_wd = function(pdata_path, ...){
  stopifnot(file.exists(pdata_path))
  current_dir = getwd()
  setwd(dirname(pdata_path))
  remotes::install_git(basename(pdata_path), ...)
  setwd(current_dir)
  invisible()
}
