#' Download spatial data of Brazilian environmental conservation units
#'
#' @description
#' This data set covers the whole of Brazil and it includes the polygons of all
#' conservation units present in Brazilian territory. The last update of the data
#' was 09-2019. The original data comes from MMA and can be found at "http://mapas.mma.gov.br/i3geo/datadownload.htm".
#'
#' @template date
#' @template simplified
#' @template showProgress
#' @template cache
#'
#' @return An `"sf" "data.frame"` object
#'
#' @export
#' @family general area functions
#'
#' @examplesIf identical(tolower(Sys.getenv("NOT_CRAN")), "true")
#' # Read conservation_units
#' b <- read_conservation_units(date = 201909)
#'
read_conservation_units <- function(date = NULL,
                                    simplified = TRUE,
                                    showProgress = TRUE,
                                    cache = TRUE){

  # Get metadata with data url addresses
  temp_meta <- select_metadata(geography="conservation_units", year=date, simplified=simplified)

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
