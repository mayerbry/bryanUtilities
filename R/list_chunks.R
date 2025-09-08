#' List chunk names in an R Markdown file
#'
#' This function scans an R Markdown (`.Rmd`) file and extracts the names
#' of all explicitly named R code chunks. By default, it looks in the
#' current working directory (`"."`) and uses the single `.Rmd` file found there.
#'
#' @param file A path to a `.Rmd` file or to a directory. If a directory
#'   is supplied, the function will search for `.Rmd` files within it.
#'   Defaults to the current directory (`"."`).
#'
#' @return A character vector of chunk names. Unnamed chunks are ignored.
#'
#' @examples
#' \dontrun{
#' # From a specific file
#' list_chunks("analysis.Rmd")
#'
#' # From the working directory (must contain exactly one .Rmd)
#' list_chunks()
#' }
#'
#' @export
list_chunks <- function(file = ".") {
  # if input is a directory, look for Rmd files
  if (dir.exists(file)) {
    rmds <- list.files(file, pattern = "\\.Rmd$", full.names = TRUE)
    if (length(rmds) == 0) stop("no rmd found")
    if (length(rmds) > 1) stop("more than one rmd")
    file <- rmds
  }

  # read the file
  lines <- readLines(file, warn = FALSE)

  # regex to match chunk headers of the form ```{r name, ...}
  chunk_lines <- grep("^```\\{r.*\\}", lines, value = TRUE)

  # extract names
  chunk_names <- sub("^```\\{r\\s*([^,}]*)[ ,}].*", "\\1", chunk_lines)

  # keep only non-empty names
  chunk_names <- chunk_names[chunk_names != ""]

  return(chunk_names)
}
