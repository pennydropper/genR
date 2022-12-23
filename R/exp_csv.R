#' Exports a data table to a CSV with various options
#'
#' @param .tbl Tibble or data table to export
#' @param .file_pref The name of the destination file
#' @param .download_dir The destination of the exported file
#' @param .tidy_nms Enter 1 to tidy the column names (e.g. replace "_" with a space and set to title case)
#' @param .glimpse Enter TRUE to print a glimpse of the tibble while exporting to a CSV.
#' @param .print Enter TRUE to print the tibble while exporting to a CSV
#' @param .open Enter TRUE to open the file in the default application
#' @param .suffix_pref Enter TRUE to append the .file_pref to the file name after the date suffix
#' @param .incl_date Enter TRUE to append a date/time suffix to the file name
#'
#' @return Prints a summary of the exported file
#' @export
#'
#' @examples exp_csv(iris, "iris_exp", "~", .open = FALSE, .incl_date = FALSE)

exp_csv <- function(.tbl, .file_pref, .download_dir = "~", .tidy_nms = 0, .glimpse = FALSE, .print = FALSE, .open = TRUE,
                    .suffix_pref = FALSE, .incl_date = TRUE) {
  # Exports the CSV with some optional enhancements

  if (.incl_date) {
    destn <-
      stringr::str_c(.download_dir, "/", stringr::str_c(.file_pref, " ", format.Date(lubridate::now(), "%Y.%m.%d %H.%M"),
                                      if(.suffix_pref) {stringr::str_c(" ", .file_pref)}, ".csv"))
  } else {
    destn <- stringr::str_c(.download_dir, "/", .file_pref, ".csv")
  }

  cat("Extracting data to ", destn, "\n\n")

  if (.tidy_nms == 1) {
    .tbl <-
      purrr::set_names(.tbl, ~ str_replace_all(., "_", " ") %>% stringr::str_to_title())
  }

  if (.glimpse) {dplyr::glimpse(.tbl, width = 50)}
  if (.print) {print(.tbl)}

  .tbl %>%
    readr::write_csv(file = destn,
              na = "")

  if (.open) {
    # Open template file to copy the format
    shell.exec(normalizePath(destn) %>%  stringr::str_replace_all("/", "\\"))

  }

}
