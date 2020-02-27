% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/whatr-plot.R
\name{whatr_plot}
\alias{whatr_plot}
\title{What is a plot?}
\usage{
whatr_plot(game)
}
\arguments{
\item{game}{Either a numeric J! Archive game ID or the HTML document object
returned by \code{\link[=whatr_html]{whatr_html()}}, which can take a game ID, air date, show
number, or another HTML document as an input. If an HTML document is not
provided, \code{\link[=whatr_html]{whatr_html()}} will be called.}
}
\value{
A ggplot object.
}
\description{
This type of graphic presents data in a visual manner.
}
\examples{
whatr_plot(game = 6304)
whatr_html("2019-06-04", "showscores") \%>\% whatr_plot()
}