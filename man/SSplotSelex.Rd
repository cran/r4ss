% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SSplotSelex.R
\name{SSplotSelex}
\alias{SSplotSelex}
\title{Plot selectivity}
\usage{
SSplotSelex(
  replist,
  infotable = NULL,
  fleets = "all",
  fleetnames = "default",
  sizefactors = c("Lsel"),
  agefactors = c("Asel", "Asel2"),
  years = "endyr",
  minyr = -Inf,
  maxyr = Inf,
  season = 1,
  sexes = "all",
  selexlines = 1:6,
  subplot = 1:25,
  skipAgeSelex10 = TRUE,
  plot = TRUE,
  print = FALSE,
  add = FALSE,
  labels = c("Length (cm)", "Age (yr)", "Year", "Selectivity", "Retention",
    "Discard mortality"),
  col1 = "red",
  col2 = "blue",
  lwd = 2,
  spacepoints = 5,
  staggerpoints = 1,
  legendloc = "bottomright",
  pwidth = 6.5,
  pheight = 5,
  punits = "in",
  res = 300,
  ptsize = 10,
  cex.main = 1,
  mainTitle = TRUE,
  showmain = lifecycle::deprecated(),
  mar = NULL,
  plotdir = "default",
  verbose = TRUE
)
}
\arguments{
\item{replist}{A list object created by \code{\link{SS_output}()}.}

\item{infotable}{Optional table of information controlling appearance of
plot and legend. Is produced as output and can be modified and entered as
input.}

\item{fleets}{Optional vector to subset fleets for which to make plots}

\item{fleetnames}{Optional replacement for fleenames used in data file}

\item{sizefactors}{Which elements of the factors column of SIZE_SELEX should
be included in plot of selectivity across multiple fleets?}

\item{agefactors}{Which elements of the factors column of AGE_SELEX should
be included in plot of selectivity across multiple fleets?}

\item{years}{Which years for selectivity are shown in multi-line plot
(default = last year of model).}

\item{minyr}{optional input for minimum year to show in plots}

\item{maxyr}{optional input for maximum year to show in plots}

\item{season}{Which season (if seasonal model) for selectivity shown in
multi-line plot (default = 1).}

\item{sexes}{Optional vector to subset genders for which to make plots
(1=females, 2=males)}

\item{selexlines}{Vector to select which lines get plotted. values are 1.
Selectivity, 2. Retention, 3. Discard mortality, 4. Keep.}

\item{subplot}{Vector controlling which subplots to create.
Numbering of subplots is as follows,

\emph{Plots with all fleets grouped together}
\itemize{
\item 1 selectivity at length in end year for all fleets shown together
\item 2 selectivity at age in end year for all fleets shown together
(this includes both age-based selectivity "Asel" and age values derived
from length-based, "Asel2". You can choose only one using
"agefactors" if needed.)
}

\emph{Plots of time-varying length-based selectivity}
\itemize{
\item 3 selectivity at length time-varying surface
\item 4 selectivity at length time-varying contour
\item 5 retention at length time-varying surface
\item 6 retention at length time-varying surface
\item 7 discard mortality time-varying surface
\item 8 discard mortality time-varying contour
}

\emph{Selectivity at length in end year by fleet}
\itemize{
\item 9 selectivity, retention, and discard mortality at length in ending year
}

\emph{Plots of time-varying age-based selectivity}
\itemize{
\item 11 selectivity at age time-varying surface
\item 12 selectivity at age time-varying contour
}

\emph{Selectivity at age in end year by fleet}
\itemize{
\item 13 selectivity at age in ending year if time-varying
\item 14 selectivity at age in ending year if NOT time-varying
\item 15 matrix of selectivity deviations for semi-parametric selectivity
}

\emph{Selectivity for both/either age or length}
\itemize{
\item 21 selectivity at age and length contour with overlaid growth curve
\item 22 selectivity with uncertainty if requested at end of control file
}}

\item{skipAgeSelex10}{Exclude plots for age selectivity type 10 (selectivity
= 1.0 for all ages beginning at age 1)?}

\item{plot}{Plot to active plot device?}

\item{print}{Print to PNG files?}

\item{add}{Add to existing plot (not yet implemented)}

\item{labels}{vector of labels for plots (titles and axis labels)}

\item{col1}{color for female growth curve}

\item{col2}{color for male growth curve}

\item{lwd}{Line widths for plots}

\item{spacepoints}{number of years between points shown on top of lines (for
long timeseries, points every year get mashed together)}

\item{staggerpoints}{number of years to stagger the first point (if
\code{spacepoints > 1}) for each line (so that adjacent lines have points in
different years)}

\item{legendloc}{location of legend. See ?legend for more info.}

\item{pwidth}{Default width of plots printed to files in units of
\code{punits}. The default is \code{pwidth=6.5}.}

\item{pheight}{Height of plots printed to png files in units of \code{punits}.
Default is designed to allow two plots per page, with \code{pheight_tall} used
for plots that work best with a taller format and a single plot per page.}

\item{punits}{Units for \code{pwidth} and \code{pheight}. Can be "px"
(pixels), "in" (inches), "cm" (centimeters), or "mm" (millimeters).
The default is \code{punits="in"}.}

\item{res}{Resolution of plots printed to files.
The default is \code{res = 300}.}

\item{ptsize}{Point size for plotted text in plots printed to files (see
\code{help("png")} in R for details).}

\item{cex.main}{character expansion for plot titles}

\item{mainTitle}{Logical indicating if a title should be included at the top
(not yet implemented for all plots)}

\item{showmain}{Deprecated, use mainTitle instead.}

\item{mar}{Either NULL to allow the default (which depends on whether the main title is included or not) or a numerical vector of the form c(bottom, left, top, right) which gives the number of lines of margin to be specified on the four sides of the plot, which is passed to \code{par()}.}

\item{plotdir}{Directory where PNG files will be written. By default it will
be the directory where the model was run.}

\item{verbose}{A logical value specifying if output should be printed
to the screen.}
}
\description{
Plot selectivity, including retention and other quantities, with additional
plots for time-varying selectivity.
}
\seealso{
\code{\link[=SS_plots]{SS_plots()}}, \code{\link[=SS_output]{SS_output()}}
}
\author{
Ian Stewart, Ian Taylor
}
