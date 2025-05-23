% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ivo_tables.R
\encoding{UTF-8}
\name{ivo_flextable_theme}
\alias{ivo_flextable_theme}
\title{Use nice fonts and colors for tables}
\usage{
ivo_flextable_theme(
  x,
  kway = 2,
  rowsums = FALSE,
  caption = NA,
  highlight_cols = NULL,
  highlight_rows = NULL,
  color = "darkgreen",
  font_name = "Arial",
  bold_cols = NULL
)
}
\arguments{
\item{x}{A flextable.}

\item{kway}{The number of "horizontal" variables in the table.}

\item{rowsums}{A logical, saying whether the rightmost column in the table contains the sum of each row. Defaults to FALSE.}

\item{caption}{An optional string containing a table caption.}

\item{highlight_cols}{A numeric vector containing the indices of the columns that should be highlighted.}

\item{highlight_rows}{A numeric vector containing the indices of the rows that should be highlighted.}

\item{color}{A named color or a color HEX code, used for the lines in the table. Defaults to "darkgreen".}

\item{font_name}{The name of the font to be used in the table. Defaults to "Arial".}

\item{bold_cols}{A numeric vector containing the indices of the columns that should use a bold font.}
}
\value{
A styled flextable.
}
\description{
A flextable theme for ivo_table objects.
}
\details{
The default settings use a dark green color and a sans serif font.
}
\examples{
library(tidyr)
library(dplyr)
library(flextable)
example_data <- data.frame(Year = sample(2020:2023, 50, replace = TRUE),
A = sample(c("Type 1", "Type 2"), 50, replace = TRUE),
B = sample(c("Apples", "Oranges", "Bananas"), 50, replace = TRUE),
C = sample(c("Swedish", "Norwegian", "Chilean"), 50, replace = TRUE))
example_data |> select(B, A) |>
  ftable(exclude=NULL) |>
  data.frame() |>
  spread(A, Freq) |>
  regulartable() |>
  ivo_flextable_theme()
}
\author{
Måns Thulin
}
