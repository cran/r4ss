#' Read admodel.hes file
#'
#' This function reads in all of the information contained in the
#' .hes file. Some is needed for relaxing the covariance matrix, while the rest
#' is recorded and rewritten to file as ADMB expects.
#' @param File Directory in which .hes file is located. Defaults to the working
#'  directory.
#' @param FileName Name of .hes file. Defaults to admodel.hes.
#' @return A list with elements num.pars, hes, hybrid_bounded_flag, and scale.
#' @author Cole Monnahan
#' @export
#' @seealso [read.admbFit()], [NegLogInt_Fn()]
#' @note Explanation of the methods (in PDF form):
#' <https://github.com/admb-project/admb-examples/blob/master/admb-tricks/covariance-calculations/ADMB_Covariance_Calculations.pdf>
getADMBHessian <- function(File = getwd(), FileName = "admodel.hes") {
  filename <- file(file.path(File, FileName), "rb")
  on.exit(close(filename))
  num.pars <- readBin(filename, "integer", 1)
  hes.vec <- readBin(filename, "numeric", num.pars^2)
  hes <- matrix(hes.vec, ncol = num.pars, nrow = num.pars)
  hybrid_bounded_flag <- readBin(filename, "integer", 1)
  scale <- readBin(filename, "numeric", num.pars)
  result <- list(
    num.pars = num.pars, hes = hes,
    hybrid_bounded_flag = hybrid_bounded_flag, scale = scale
  )
  return(result)
}
