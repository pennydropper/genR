
<!-- README.md is generated from README.Rmd. Please edit that file -->

# genR

<!-- badges: start -->
<!-- badges: end -->

The goal of genR is to install generic functions to read and write
files.

Functions include selecting files to import, exporting tables to CSV
files and reading and writing lists of objects to RDS files.

## Installation

You can install the development version of genR like so:

``` r
# install.packages("remotes")
# remotes::install_github("pennydropper/genR")
```

## Example

This is a basic example which shows you how to use genR:

``` r
library(genR)
## basic example code
```

First, use a character vector to list the names of objects that you want
to export to RDS files and import from RDS files.

Note that the objects can be of any type, including dataframes, tibbles,
list objects etc.

``` r

mtcars_cp <- mtcars
letter_cp <- letters

preserve_objs <- 
  c(
    "mtcars_cp",
    "letter_cp"
  )
```

Executing `write_dfs` will step through each name in the vector, confirm
that an object with that name exists then export the object to an `.RDS`
file in the specified directory.

Upon completion, `write_dfs` will confirm which objects were
successfully exported to `.RFS` files.

``` r
# write_dfs(preserve_objs, "~")
write_dfs(preserve_objs, "~")
#> 
#> Objects extracted:
#>  mtcars_cp
#>  letter_cp
```

Executing `retrieve_dfs` will step through each name listed in the
vector, confirm whether an `.RDS` file with that name exists in the
specified directory, then import that `.RDS` file and save it as an
object with that name.

`retrieve_dfs` completes it’s task by listing:  
- Each file’s modified date.  
- The vector entries where an `.RDS` file was not found.

``` r
retrieve_dfs(preserve_objs, "~")
#>      tbl_nm               mtime
#> 1 letter_cp 2022-12-23 16:41:11
#> 2 mtcars_cp 2022-12-23 16:41:11
#> 
#> All requested objects retrieved
```
