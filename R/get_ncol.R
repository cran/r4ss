#' Calculate the number of columns in `Report.sso`
#'
#' The number of columns is important for the optimization of
#' [SS_output()]. Using a `while` loop, this function
#' finds the optimum width for reading in data as a table and
#' decreases the need for users to pre-specify a width when reading
#' in files.
#'
#' @template file
#' @param nrows integer: the maximum number of rows to read in.
#' Negative and other invalid values are ignored.
#' @param skip integer: the number of lines of the data file to skip
#' before beginning to read data.
#' @noRd
#' @return
#' An integer value specifying the number of columns in `file`.
#' @author Kelli F. Johnson
#' @seealso [SS_output()]
#'
get_ncol <- function(file, skip = 0, nrows = -1) {
  numcol <- list("yes")
  initial <- 100
  while (!all(numcol[length(numcol)] == "")) {
    numcol <- utils::read.table(file,
      col.names = 1:initial, fill = TRUE, quote = "",
      colClasses = "character", nrows = nrows, skip = skip,
      comment.char = ""
    )
    initial <- initial + 100
  }
  nummax <- max(which(
    apply(numcol, 2, function(x) all(x == "")) == FALSE
  )) + 1
  return(nummax)
}
