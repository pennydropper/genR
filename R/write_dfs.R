#' Exports the specified objects to RDS files.
#'
#' @param .objs Character vector of the names of objects to export to DFS files.
#' @param .dir Destination directory for the exported DFS files.
#' @usage write_dfs(.objs, .dir)
#' @return Objects are exported to DFS files and confirmation printed to the console.
#' Objects not found (if any) are also listed.
#' @export
#'
#' @examples
#' write_dfs(c("mt_cars"), .dir = "~")
write_dfs <- function(.objs, .dir) {
  # Write objects specified in .objs char vector to rds files in .dir

  curr_objs <- ls(envir=.GlobalEnv)

  objs_exist <-
    purrr::keep(.objs, ~ (. %in% curr_objs)) %>%
    unique()

  objs_missing <-
    purrr::keep(.objs, ~ !(. %in% curr_objs)) %>%
    unique()

  if (length(objs_missing) > 0) {
    # List the missing objects
    cat("These objects do not exist:\n\t")
    cat(objs_missing, sep = "\n\t")
  }

  if (length(objs_exist) > 0) {
    objs_exist %>%
      purrr::walk(., ~ readr::write_rds(get(.), stringr::str_c(.dir, str_c(., ".rds", sep = ""), sep = "/"), "none"))

    cat("\nObjects extracted:\n\t")
    cat(objs_exist, sep = "\n\t")


  } else {
    cat("\nNone of the listed objects currently exist.\n")
  }

}
