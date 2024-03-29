% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SS_parlines.R
\name{SS_parlines}
\alias{SS_parlines}
\title{Get parameter lines from Stock Synthesis control file}
\usage{
SS_parlines(
  ctlfile = "control.ss_new",
  dir = NULL,
  version = "3.30",
  verbose = TRUE,
  active = FALSE
)
}
\arguments{
\item{ctlfile}{File name of control file including path.}

\item{dir}{Alternative input of path, where file is assumed to be
"control.ss_new". Default=NULL.}

\item{version}{SS version number. Currently only "3.24" or "3.30" are supported,
either as character or numeric values (noting that numeric 3.30  = 3.3).}

\item{verbose}{TRUE/FALSE switch for amount of detail produced by function.
Default=TRUE.}

\item{active}{Should only active parameters (those with positive phase) be
output? Default=FALSE.}
}
\description{
A simple function which takes as input the full path and filename of a
control file for input to Stock Synthesis. Ideally, a Control.SS_New file
will be used, so that it represents what SS thinks the inputs are, and not
what the user thinks the inputs are.
}
\details{
It returns a table which should contain one line for each parameter in the
model. Currently, only the first 7 values are returned, because all
parameters have those values. In the future, extended parameter lines could
be returned.

Parameter lines are identified as those which have 7 or 14 numeric elements
followed by a non-numeric element. It's possible that this system could
break down under certain circumstances
}
\examples{
\dontrun{
parlines <- SS_parlines(ctlfile = "c:/ss/Simple/Control.SS_New")
head(parlines)
#       LO    HI     INIT PRIOR PR_type   SD PHASE              Label Line_num
# 42  0.05  0.15  0.10000  0.10       0  0.8    -3  NatM_p_1_Fem_GP_1       42
# 43  0.05  0.15  0.10000  0.10       0  0.8    -3  NatM_p_2_Fem_GP_1       43
# 44  1.00 45.00 32.28100 36.00       0 10.0     2 L_at_Amin_Fem_GP_1       44
# 45 40.00 90.00 71.34260 70.00       0 10.0     4 L_at_Amax_Fem_GP_1       45
# 46  0.05  0.25  0.15199  0.15       0  0.8     4 VonBert_K_Fem_GP_1       46
# 47  0.05  0.25  0.10000  0.10       0  0.8    -3  CV_young_Fem_GP_1       47
}

}
\seealso{
\code{\link[=SS_changepars]{SS_changepars()}}, \code{\link[=SS_readctl]{SS_readctl()}},
\code{\link[=SS_readctl_3.24]{SS_readctl_3.24()}}
}
\author{
Ian Taylor
}
