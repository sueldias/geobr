#' Download urban concentration areas in Brazil
#'
#' @description
#' This function reads the official data on the urban concentration areas (Areas
#' de Concentracao de Populacao) of Brazil. Original data were generated by the
#' Institute of Geography and Statistics (IBGE)  For more information about the
#' methodology, see details at \url{https://www.ibge.gov.br/apps/arranjos_populacionais/2015/pdf/publicacao.pdf}
#'
#' @template year
#' @template simplified
#' @template showProgress
#' @template cache
#'
#'
#' @return An `"sf" "data.frame"` object
#'
#' @export
#' @family area functions
#'
#' @examplesIf identical(tolower(Sys.getenv("NOT_CRAN")), "true")
#' # Read urban footprint of Brazilian cities in an specific year
#' uc <- read_urban_concentrations(year=2015)
#'
read_urban_concentrations <- function(year = NULL,
                                      simplified = TRUE,
                                      showProgress = TRUE,
                                      cache = TRUE){

  # Get metadata with data url addresses
  temp_meta <- select_metadata(geography="urban_concentrations", year=year, simplified=simplified)

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
