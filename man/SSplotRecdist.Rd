% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SSplotRecdist.R
\name{SSplotRecdist}
\alias{SSplotRecdist}
\title{Plot of recruitment distribution among areas and seasons}
\usage{
SSplotRecdist(
  replist,
  plot = TRUE,
  print = FALSE,
  areanames = NULL,
  seasnames = NULL,
  xlab = "",
  ylab = "",
  main = "Distribution of recruitment by area and season",
  plotdir = "default",
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

\item{areanames}{optional vector to replace c("Area1","Area2",...)}

\item{seasnames}{optional vector to replace c("Season1","Season2",...)}

\item{xlab}{optional x-axis label (if the area names aren\'t informative
enough)}

\item{ylab}{optional y-axis label (if the season names aren\'t informative
enough)}

\item{main}{title for plot}

\item{plotdir}{directory where PNG files will be written. by default it will
be the directory where the model was run.}

\item{pwidth}{width of plot}

\item{pheight}{height of plot}

\item{punits}{units for PNG file}

\item{res}{Resolution of plots printed to files.
The default is \code{res = 300}.}

\item{ptsize}{point size for PNG file}

\item{cex.main}{character expansion for plot titles}

\item{verbose}{report progress to R GUI?}
}
\description{
Image plot shows fraction of recruitment in each combination of area and
season. This is based on the RECRUITMENT_DIST section of the Report.sso
file.
}
\seealso{
\code{\link[=SS_plots]{SS_plots()}}, \code{\link[=SSplotRecdevs]{SSplotRecdevs()}}
}
\author{
Ian Taylor
}
