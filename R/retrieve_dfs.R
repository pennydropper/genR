#' Retrieve objects stored in DFS files
#'
#' @param .objs Character vector of RDS files to retrieve
#' @param .dir Directory where RDS files are located
#'
#' @return Imports objects in RDS files. Prints a list of successful imports and unsuccessful imports
#' @export
#' @importFrom magrittr %T>%
#'
#'

retrieve_dfs <- function(.objs, .dir){
  # Retrieve objects specified in .objs char vector to rds files in .dir

  dir_files <-
    list.files(path = .dir,
               pattern = "\\.rds$",
               recursive = TRUE,
               ignore.case = TRUE,
               include.dirs = FALSE) %>%
    # Will pick up sub-directories, including Archive, which is OK
    purrr::discard(~stringr::str_detect(., "~")) %>%
    # Discard any shortcut objects
    stringr::str_c(.dir, ., sep = "/") %>%
    file.info(path = .,
              extra_cols = TRUE) %>%
    tibble::rownames_to_column(var = "flnm") %>%
    dplyr::filter(!is.na(size)) %>%
    dplyr::mutate(file = stringr::str_extract(flnm, "[^////]+$"),
           tbl_nm = stringr::str_replace(file, "\\.rds$", ""))

  dir_files %>%
    dplyr::filter(tbl_nm %in% .objs) %>%
    dplyr::arrange(tbl_nm) %>%
    dplyr::select(tbl_nm, mtime) %T>%
    {print(.)} %>%
    dplyr::pull(tbl_nm) %>%
    purrr::walk(., ~ assign(., readr::read_rds(stringr::str_c(.dir, stringr::str_c(., ".rds", sep = ""), sep = "/")), envir = .GlobalEnv))

  obs_mssng <-
    purrr::discard(.objs, ~ (. %in% dir_files$tbl_nm)) %>%
    unique()

  if (length(obs_mssng) == 0) {
    cat("\nAll requested objects retrieved")
  } else {
    cat("\nThese objects not found in ", .dir, "\n\t")
    cat(obs_mssng, "\n\t")
  }

}
