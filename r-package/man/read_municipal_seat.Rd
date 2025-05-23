% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_municipal_seat.R
\name{read_municipal_seat}
\alias{read_municipal_seat}
\title{Download spatial data of municipal seats (sede dos municipios) in Brazil}
\usage{
read_municipal_seat(year = NULL, showProgress = TRUE, cache = TRUE)
}
\arguments{
\item{year}{Numeric. Year of the data in YYYY format. It defaults to \code{NULL}
and reads the data from the latest year available.}

\item{showProgress}{Logical. Defaults to \code{TRUE} display progress bar.}

\item{cache}{Logical. Whether the function should read the data cached
locally, which is faster. Defaults to \code{cache = TRUE}. By default,
\code{geobr} stores data files in a temporary directory that exists only
within each R session. If \code{cache = FALSE}, the function will download
the data again and overwrite the local file.}
}
\value{
An \verb{"sf" "data.frame"} object
}
\description{
This function reads the official data on the municipal seats (sede dos municipios)
of Brazil. The data brings the geographical coordinates (lat lon) of municipal
seats for various years between 1872 and 2010. Original data were generated by
Brazilian Institute of Geography and Statistics (IBGE).
}
\examples{
\dontshow{if (identical(tolower(Sys.getenv("NOT_CRAN")), "true")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
# Read municipal seats in an specific year
m <- read_municipal_seat(year = 1991)
\dontshow{\}) # examplesIf}
}
\seealso{
Other area functions: 
\code{\link{read_amazon}()},
\code{\link{read_biomes}()},
\code{\link{read_capitals}()},
\code{\link{read_comparable_areas}()},
\code{\link{read_country}()},
\code{\link{read_disaster_risk_area}()},
\code{\link{read_health_facilities}()},
\code{\link{read_health_region}()},
\code{\link{read_immediate_region}()},
\code{\link{read_indigenous_land}()},
\code{\link{read_intermediate_region}()},
\code{\link{read_meso_region}()},
\code{\link{read_metro_area}()},
\code{\link{read_micro_region}()},
\code{\link{read_municipality}()},
\code{\link{read_neighborhood}()},
\code{\link{read_pop_arrangements}()},
\code{\link{read_region}()},
\code{\link{read_schools}()},
\code{\link{read_semiarid}()},
\code{\link{read_state}()},
\code{\link{read_statistical_grid}()},
\code{\link{read_urban_area}()},
\code{\link{read_urban_concentrations}()},
\code{\link{read_weighting_area}()}
}
\concept{area functions}
