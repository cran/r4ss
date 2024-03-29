% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SS_readwtatage.R
\name{SS_readwtatage}
\alias{SS_readwtatage}
\title{Read weight-at-age data file}
\usage{
SS_readwtatage(file = "wtatage.ss", verbose = TRUE)
}
\arguments{
\item{file}{Filename either with full path or relative to working directory.

See the formal arguments for a possible default filename.}

\item{verbose}{A logical value specifying if output should be printed
to the screen.}
}
\value{
Returns a data frame with a variable number of columns based on the
number of ages that are included in the file. Though, the first columns
will always be Yr, Seas, Sex, Bio_Pattern, BirthSeas, and Fleet.
The seventh column will be age zero.
The last or next to last column will be the maximum age included
in the weight-at-age data. For SS version 3.30 and greater, the last column
will be a column of comments.
}
\description{
Read in a weight-at-age data file into a data frame in R.
}
\author{
Kelli F. Johnson, Ian G. Taylor
}
