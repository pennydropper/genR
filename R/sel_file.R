#' Select a file, usually to import, and post a message with the file's date stamp
#'
#' @param .caption Enter a prompt for the dialogue box displayed when selecting the file
#' @param .path Enter the default path to the file
#' @param .filter Enter the default file name pattern to streamline the file's selection
#'
#' @return Returns a string value with the selected file's path and name. Also prints the file's full path and a date stamp
#' @export
#'
#'
#'

sel_file <- function(.caption = "Select file to open", .path = "~", .filter = "*.xlsx") {
  # Prompts to select a file and returns a string of the file name and location
  beepr::beep()

  sel_flnm <-
    rstudioapi::selectFile(
      caption = .caption,
      label = "Select",
      path = .path,
      filter = .filter,
      existing = TRUE
    )

  mod_time <-
    file.mtime(sel_flnm)


  cat(stringr::str_c(.caption, " ", lubridate::now() %>% format.Date(format = "%I:%M %p on %a %d/%m")),
      sel_flnm,
      stringr::str_c("File modified: ", format.POSIXct(mod_time)),
      "", sep = "\n")

  sel_flnm

}
