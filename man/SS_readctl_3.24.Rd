% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SS_readctl_3.24.R
\name{SS_readctl_3.24}
\alias{SS_readctl_3.24}
\title{read control file from SS version 3.24}
\usage{
SS_readctl_3.24(
  file,
  verbose = FALSE,
  echoall = lifecycle::deprecated(),
  version = lifecycle::deprecated(),
  use_datlist = TRUE,
  datlist = "data.ss_new",
  nseas = NULL,
  N_areas = NULL,
  Nages = NULL,
  Ngenders = lifecycle::deprecated(),
  Nsexes = NULL,
  Npopbins = NA,
  Nfleet = NULL,
  Nsurveys = NULL,
  Do_AgeKey = NULL,
  N_tag_groups = NULL,
  N_CPUE_obs = NULL,
  ptype = FALSE
)
}
\arguments{
\item{file}{Filename either with full path or relative to working directory.

See the formal arguments for a possible default filename.}

\item{verbose}{Should there be verbose output while running the file?
Defaults to FALSE.}

\item{echoall}{Deprecated. Debugging tool (not fully implemented) of echoing
blocks of values as it is being read.}

\item{version}{Deprecated. SS version number. Currently only "3.24" or "3.30" are supported,
either as character or numeric values (noting that numeric 3.30  = 3.3).}

\item{use_datlist}{LOGICAL if TRUE, use datlist to derive parameters which
can not be determined from control file. Defaults to TRUE}

\item{datlist}{list or character. if list : produced from SS_writedat
or character : file name of dat file.}

\item{nseas}{number of seasons in the model. This information is not
explicitly available in control file and used only if \code{use_datlist = FALSE}.}

\item{N_areas}{number of spatial areas in the model. Default = 1. This information is not
explicitly available in control file and used only if if \code{use_datlist = FALSE}.}

\item{Nages}{oldest age in the model. This information is also not
explicitly available in control file and used only if \code{use_datlist = FALSE}.}

\item{Ngenders}{Deprecated. Number of sexes in the model. This information is also not
explicitly available in control file and used only if \code{use_datlist = FALSE}.}

\item{Nsexes}{number of sexes in the model. This information is also not
explicitly available in control file and used only if \code{use_datlist = FALSE}.}

\item{Npopbins}{number of population bins in the model. This information is also not
explicitly available in control file and this information is only required if length based
maturity vector is directly supplied (Maturity option of 6).  and used only
if \code{use_datlist = FALSE}.}

\item{Nfleet}{number of fisheries in the model. This information is also not
explicitly available in control file}

\item{Nsurveys}{number of survey fleets in the model. This information is also not
explicitly available in control file}

\item{Do_AgeKey}{Flag to indicate if 7 additional ageing error parameters to
be read set 1 (but in fact any non zero numeric in R) or TRUE to enable to
read them 0 or FALSE to disable them. This information is not
explicitly available in control file and used only if \code{use_datlist = FALSE}.}

\item{N_tag_groups}{number of tag release group. Default =NA. This information
is not explicitly available control file  and used only if
\code{use_datlist = FALSE}. This information is only required if custom tag
parameters is enabled (TG_custom=1)}

\item{N_CPUE_obs}{numeric vector of length=Nfleet+Nsurveys containing number
of data points of each CPUE time series}

\item{ptype}{include a column in the output indicating parameter type?
(Can be useful, but causes problems for SS_writectl.) Defaults to FALSE.}
}
\description{
Read Stock Synthesis (version 3.24) control file into list object in R.
This function comes with its wrapper function SS_readctl
that calls SS_readctl_3.24 (this function) or SS_readctl_3.30
(to be available in future).
}
\seealso{
\code{\link[=SS_readctl]{SS_readctl()}}, \code{\link[=SS_readdat]{SS_readdat()}}
\code{\link[=SS_readdat_3.24]{SS_readdat_3.24()}},\code{\link[=SS_readdat_3.30]{SS_readdat_3.30()}}
\code{\link[=SS_readstarter]{SS_readstarter()}}, \code{\link[=SS_readforecast]{SS_readforecast()}},
\code{\link[=SS_writestarter]{SS_writestarter()}},
\code{\link[=SS_writeforecast]{SS_writeforecast()}}, \code{\link[=SS_writedat]{SS_writedat()}}
}
\author{
Yukio Takeuchi, Neil Klaer, Iago Mosqueira, and Kathryn Doering
}
