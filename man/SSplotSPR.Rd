% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SSplotSPR.R
\name{SSplotSPR}
\alias{SSplotSPR}
\title{Plot Spawning Potential Ratio (SPR) quantities.}
\usage{
SSplotSPR(
  replist,
  add = FALSE,
  plot = TRUE,
  print = FALSE,
  uncertainty = TRUE,
  subplots = 1:4,
  forecastplot = FALSE,
  col1 = "black",
  col2 = "blue",
  col3 = "green3",
  col4 = "red",
  sprtarg = "default",
  btarg = "default",
  labels = c("Year", "SPR", "1-SPR", "Relative fishing intensity",
    "Relative spawning output"),
  pwidth = 6.5,
  pheight = 5,
  punits = "in",
  res = 300,
  ptsize = 10,
  cex.main = 1,
  plotdir = "default",
  verbose = TRUE
)
}
\arguments{
\item{replist}{A list object created by \code{\link{SS_output}()}.}

\item{add}{add to existing plot (not yet implemented)}

\item{plot}{plot to active plot device?}

\item{print}{print to PNG files?}

\item{uncertainty}{include plots showing uncertainty?}

\item{subplots}{vector controlling which subplots to create
Numbering of subplots is as follows:
\enumerate{
\item timeseries of SPR,
\item timeseries of 1 - SPR,
\item timeseries of SPR ratio (as specified in the starter file), and
\item phase plot of Biomass ratio vs SPR ratio (as specified in the
starter file).
}}

\item{forecastplot}{Include forecast years in plot?}

\item{col1}{first color used}

\item{col2}{second color used}

\item{col3}{third color used}

\item{col4}{fourth color used}

\item{sprtarg}{F/SPR proxy target. "default" chooses based on model output,
where models which have SPR_report_basis = 0 or 1 specified in the starter
file will use the SPR target specified in the forecast file. Models which
have SPR_report_basis = 2 will use SPR at MSY for the SPR target
and models which have the SPR_report_basis = 3 will use
SPR at Btarget for the SPR target in these plots. Zero or negative values of
sprtarg input here will cause no horizontal line to be plotted.}

\item{btarg}{target depletion to be used in plots showing depletion. May be
omitted by setting to NA. "default" chooses based on model output.}

\item{labels}{vector of labels for plots (titles and axis labels)}

\item{pwidth}{width of plot}

\item{pheight}{height of plot}

\item{punits}{units for PNG file}

\item{res}{Resolution of plots printed to files.
The default is \code{res = 300}.}

\item{ptsize}{point size for PNG file}

\item{cex.main}{character expansion for plot titles}

\item{plotdir}{directory where PNG files will be written. by default it will
be the directory where the model was run.}

\item{verbose}{report progress to R GUI?}
}
\description{
Plot time series of SPR, 1-SPR, the chosen SPR ratio and the phase plot.
}
\seealso{
\code{\link[=SS_plots]{SS_plots()}}, \code{\link[=SS_output]{SS_output()}}
}
\author{
Ian Stewart, Ian Taylor
}
