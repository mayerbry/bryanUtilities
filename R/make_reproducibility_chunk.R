


#' Creates reproducibility tables automatically
#
#' just call in chunk with results = "asis"
#'
#' @return invisible
#'
#' @examples
#' make_reproducibility_chunk()
#' @export
make_reproducibility_chunk = function(){
  output_type = VISCtemplates::get_output_type()
  my_session_info <- VISCfunctions::get_session_info()

  if (any(utils::installed.packages()[,1] == 'rmarkdown')) {
    suppressWarnings(library(rmarkdown))
  }

  pkgs_tbl <- my_session_info$packages_table |>
    dplyr::mutate(source = dplyr::if_else(nchar(source) < 20, source,
                                   paste0(stringr::str_sub(source, 1, 40), ")")))

  .table_output_switch = function(tab, output_type){
    if (output_type == "latex") {
      cat(tab)
    } else {
      cat(knitr::knit_print(tab))
    }
  }

  session_tab = kableExtra::kable(
    my_session_info$platform_table,
    format = output_type,
    booktabs = TRUE,
    linesep = "",
    label = "software-session-information",
    caption = "Reproducibility software session information"
  ) |>
    kableExtra::kable_styling(font_size = 10, latex_options = "HOLD_position")


  package_tab = kableExtra::kable(
    pkgs_tbl,
    format = output_type,
    booktabs = TRUE,
    linesep = "",
    label = "software-package-version-information",
    caption = "Reproducibility software package version information"
  ) |>
    kableExtra::kable_styling(font_size = 6, latex_options = "HOLD_position")

  .table_output_switch(session_tab, output_type)
  .table_output_switch(package_tab, output_type)

  return(invisible())

}
