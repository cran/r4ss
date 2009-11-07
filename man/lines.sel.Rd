\name{lines.sel}
\alias{lines.sel}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ a function for drawing selecitivity curves }
\description{
  This function is primarily inteded for use by the selfit function.
}
\usage{
lines.sel(x, model, sp, min.dist, max.dist, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ vector of x values (age or length) }
  \item{model}{ selectivity model "Double_Normal" or "Double_Logistic" }
  \item{sp}{ vector of parameters }
  \item{min.dist}{ minimum value for selectivity }
  \item{max.dist}{  maximum value for selectivity  }
  \item{\dots}{ other inputs (not implemented?) }
}
% \details{
%   ~~ If necessary, more details than the description above ~~
% }
% \value{
%   ~Describe the value returned
%   If it is a LIST, use
%   \item{comp1 }{Description of 'comp1'}
%   \item{comp2 }{Description of 'comp2'}
%   ...
% }
% \references{  }
\author{ Tommy Garrison }
% \note{ ~~further notes~~ 

%  % ~Make other sections like Warning with \section{Warning }{....} ~
% }
% \seealso{ ~~objects to See Also as \code{\link{help}}, ~~~ }
% \examples{
% }
% % Add one or more standard keywords, see file 'KEYWORDS' in the
% % R documentation directory.
\keyword{ dplot }
% \keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
