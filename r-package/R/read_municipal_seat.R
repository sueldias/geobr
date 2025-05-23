#' Download spatial data of municipal seats (sede dos municipios) in Brazil
#'
#' @description
#' This function reads the official data on the municipal seats (sede dos municipios)
#' of Brazil. The data brings the geographical coordinates (lat lon) of municipal
#' seats for various years between 1872 and 2010. Original data were generated by
#' Brazilian Institute of Geography and Statistics (IBGE).
#'
#' @template year
#' @template showProgress
#' @template cache
#'
#' @return An `"sf" "data.frame"` object
#'
#' @export
#' @family area functions
#'
#' @examplesIf identical(tolower(Sys.getenv("NOT_CRAN")), "true")
#' # Read municipal seats in an specific year
#' m <- read_municipal_seat(year = 1991)
#'
read_municipal_seat <- function(year = NULL,
                                showProgress = TRUE,
                                cache = TRUE){

  # Get metadata with data url addresses
  temp_meta <- select_metadata(geography="municipal_seat", year=year, simplified=FALSE)

  # list paths of files to download
  file_url <- as.character(temp_meta$download_path)

  # download files
  temp_sf <- download_gpkg(file_url = file_url,
                           showProgress = showProgress,
                           cache = cache)

  # check if download failed
  if (is.null(temp_sf)) { return(invisible(NULL)) }

  return(temp_sf)
}
