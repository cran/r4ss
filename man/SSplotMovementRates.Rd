% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SSplotMovementRates.R
\name{SSplotMovementRates}
\alias{SSplotMovementRates}
\title{Plot movement rates from model output}
\usage{
SSplotMovementRates(
  replist,
  plot = TRUE,
  print = FALSE,
  subplots = 1:2,
  plotdir = "default",
  colvec = "default",
  ylim = "default",
  legend = TRUE,
  legendloc = "topleft",
  moveseas = "all",
  min.move.age = 0.5,
  pwidth = 6.5,
  pheight = 5,
  punits = "in",
  res = 300,
  ptsize = 10,
  cex.main = 1,
  verbose = TRUE
)
}
\arguments{
\item{replist}{A list object created by \code{\link{SS_output}()}.}

\item{plot}{plot to active plot device?}

\item{print}{print to PNG files?}

\item{subplots}{which subplots to create.}

\item{plotdir}{where to put the plots (uses model directory by default)}

\item{colvec}{vector of colors for each movement rate in the plot}

\item{ylim}{optional input for y range of the plot. By default plot ranges
from 0 to 10\% above highest movement rate (not including fish staying in an
area).}

\item{legend}{add a legend designating which color goes with which pair of
areas?}

\item{legendloc}{location passed to legend function (if used)}

\item{moveseas}{choice of season for which movement rates are shown}

\item{min.move.age}{Minimum age of movement (in future will come from Report file)}

\item{pwidth}{width of plot}

\item{pheight}{height of plot}

\item{punits}{units for PNG file}

\item{res}{Resolution of plots printed to files.
The default is \code{res = 300}.}

\item{ptsize}{point size for PNG file}

\item{cex.main}{Character expansion parameter for plot titles}

\item{verbose}{Print information on function progress.}
}
\description{
Plots estimated movement rates in final year for each area/season with movement as
reported in Report.sso. If movement is time-varying, an additional figure shows
pattern across years (if the MGparm_By_Year_after_adjustments table (report:7)
is available in the Report.sso file)
}
\examples{
\dontrun{
SSplotMovementRates(myreplist)
}

}
\seealso{
\code{\link[=SS_output]{SS_output()}}, \code{\link[=SSplotMovementRates]{SSplotMovementRates()}},
}
\author{
Ian Taylor
}
