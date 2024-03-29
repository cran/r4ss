% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/NegLogInt_Fn.R
\name{NegLogInt_Fn}
\alias{NegLogInt_Fn}
\title{Perform SS implementation of Laplace Approximation}
\usage{
NegLogInt_Fn(
  File = NA,
  Input_SD_Group_Vec,
  CTL_linenum_List,
  ESTPAR_num_List,
  PAR_num_Vec,
  Int_Group_List = list(1),
  StartFromPar = TRUE,
  Intern = TRUE,
  ReDoBiasRamp = FALSE,
  BiasRamp_linenum_Vec = NULL,
  CTL_linenum_Type = NULL,
  systemcmd = FALSE,
  exe = "ss"
)
}
\arguments{
\item{File}{Directory containing Stock Synthesis files
(e.g., "C:/Users/James Thorson/Desktop/")}

\item{Input_SD_Group_Vec}{Vector where each element is the standard deviation
for a group of random effects (e.g., a model with a single group of random
effects will have Input_SD_Group_Vec be a vector of length one)}

\item{CTL_linenum_List}{List (same length as \code{Input_SD_Group_Vec}),
where each
element is a vector giving the line number(s) for the random effect standard
deviation parameter or penalty in the CTL file (and where each line will
correspond to a 7-parameter or 14-parameter line).}

\item{ESTPAR_num_List}{List (same length as \code{Input_SD_Group_Vec}),
where each
element is a vector giving the parameter number for the random effect
coefficients in that group of random effects. These "parameter numbers"
correspond to the number of these parameters in the list of parameters in the
".cor" output file.}

\item{PAR_num_Vec}{Vector giving the number in the ".par" vector for each
random effect coefficient.}

\item{Int_Group_List}{List where each element is a vector, providing a way of
grouping different random effect groups into a single category. Although
this input is still required, it is no has the former input Version has been
hardwired to Version = 1.}

\item{StartFromPar}{Logical flag (TRUE or FALSE) saying whether to start each
round of optimization from a ".par" file (I recommend TRUE)}

\item{Intern}{Logical flag saying whether to display all ss3 runtime output
in the R terminal}

\item{ReDoBiasRamp}{Logical flag saying whether to re-do the bias ramp
(using \code{\link[=SS_fitbiasramp]{SS_fitbiasramp()}}) each time Stock Synthesis is run.}

\item{BiasRamp_linenum_Vec}{Vector giving the line numbers from the CTL file
that contain the information about the bias ramp.}

\item{CTL_linenum_Type}{Character vector (same length as
\code{Input_SD_Group_Vec}),
where each element is either "Short_Param", "Long_Penalty", "Long_Penalty".
Default is NULL, and if not explicitly specified the program will attempt to
detect these automatically based on the length of relevant lines from the CTL
file.}

\item{systemcmd}{Should R call SS using "system" function instead of "shell".
This may be required when running R in Emacs on Windows. Default = FALSE.}

\item{exe}{SS executable name (excluding extension), either "ss" or "ss3".
This string is used for both calling the executable and also finding the
output files like ss.par. For 3.30, it should always be "ss" since the
output file names are hardwired in the TPL code.}
}
\description{
(Attempt to) perform the SS implementation of the Laplace Approximation
from Thorson, Hicks and Methot (2014) ICES J. Mar. Sci.
}
\examples{
\dontrun{
# need the full path because wd is changed in function
direc <- "C:/Models/LaplaceApprox/base"
if ("Optimization_record.txt" \%in\% list.files(direc)) {
  file.remove(file.path(direc, "Optimization_record.txt"))
}
Opt <- optimize(
  f = NegLogInt_Fn,
  interval = c(0.001, 0.12),
  maximum = FALSE,
  File = direc,
  Input_SD_Group_Vec = 1,
  CTL_linenum_List = list(127:131),
  ESTPAR_num_List = list(86:205),
  Int_Group_List = 1,
  PAR_num_Vec = NA,
  Intern = TRUE
)
}

}
\references{
Thorson, J.T., Hicks, A.C., and Methot, R.D. 2014. Random
effect estimation of time-varying factors in Stock Synthesis. ICES J. Mar.
Sci.
}
\seealso{
\code{\link[=read.admbFit]{read.admbFit()}}, \code{\link[=getADMBHessian]{getADMBHessian()}}
}
\author{
James Thorson
}
