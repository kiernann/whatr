% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/whatr-clues.R
\name{whatr_clues}
\alias{whatr_clues}
\title{Scrape Jeopardy game clues}
\usage{
whatr_clues(game = NULL, date = NULL, show = NULL)
}
\arguments{
\item{game}{The J-Archive! game ID number.}

\item{date}{The original date an episode aired.}

\item{show}{The sequential show number.}
}
\value{
A tidy tibble or correct answers.
}
\description{
Confusingly, clues are "questions" pased to contestants in the form of an
answer. The clues are the questions read by the host which must be answered
by the contestants.
}
\examples{
whatr_clues(game = 6304)
}