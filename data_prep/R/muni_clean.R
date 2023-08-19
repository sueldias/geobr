
# 1. Read raw data in .rds and saves geopackage output ----------------------
#' input: path to all files
#' read raw data and clean it
#' output: save clean data as geopackage
clean_muni <- function( files ){

  # detect corresponding year of files
  year <- detect_year_from_string(files[1])
  message(paste('\nCleaning', year, '\n'))

  # function to clean an individuals file
  clean_file <- function(f){
  #  f <- local_files_muni[local_files_muni %like% 2007 ][16]
  #  f <- local_files_muni[16]

  options(encoding = "UTF-8")

  # detect corresponding year of the file
  year <- detect_year_from_string(f)

  # create dir if it has not been created already
  dest_dir <- paste0('./data/municipios/', year)
  if (isFALSE(dir.exists(dest_dir))) { dir.create(dest_dir,
                                                  recursive = T,
                                                  showWarnings = FALSE) }

    # read raw file
    temp_sf <- readRDS(f)
    names(temp_sf) <- names(temp_sf) %>% tolower()

    # select columns
    if (year %like% "2000|2001|2005") {
      # dplyr::rename and subset columns
      temp_sf <- dplyr::select(temp_sf, c('code_muni'=geocodigo, 'name_muni'=nome))
    }

    if (year %like% "2007") {
      # dplyr::rename and subset columns
      temp_sf <- dplyr::select(temp_sf, c('code_muni'=geocodig_m, 'name_muni'=nome_munic))
    }

    if (year %like% "2010"){
      # dplyr::rename and subset columns
      temp_sf <- dplyr::select(temp_sf, c('code_muni'=cd_geocodm, 'name_muni'=nm_municip))
    }

    if (year %like% "2013|2014|2015|2016|2017|2018"){
      # dplyr::rename and subset columns
      temp_sf <- dplyr::select(temp_sf, c('code_muni'=cd_geocmu, 'name_muni'=nm_municip))
    }

    if (year >= 2019) {
      # dplyr::rename and subset columns
      temp_sf <- dplyr::select(temp_sf, c('code_muni'=cd_mun, 'name_muni'=nm_mun))
    }

    # add state info
    temp_sf$code_state <- substring(temp_sf$code_muni, 1,2)
    temp_sf <- add_state_info(temp_sf, column = 'code_state')

    # Add Region codes and names
    temp_sf <- add_region_info(temp_sf, 'code_state')

    # reorder columns
    temp_sf <- dplyr::select(temp_sf,'code_muni', 'name_muni', 'code_state', 'abbrev_state', 'name_state', 'code_region', 'name_region')

    # Use UTF-8 encoding
    temp_sf <- use_encoding_utf8(temp_sf)

    # # Capitalize the first letter
    # temp_sf$name_muni <- stringr::str_to_title(temp_sf$name_muni)

    # Harmonize spatial projection CRS, using SIRGAS 2000 epsg (SRID): 4674
    temp_sf <- harmonize_projection(temp_sf)


    # strange error in Espirito Santo in 2000
    unique_codes <- unique(temp_sf$code_state)
    if (length(unique_codes)==2 & any(unique_codes %in% 32)) {
      temp_sf <- subset(temp_sf, code_state ==32)
    }


    # strange error in RJ in 2000
    temp_sf <- subset(temp_sf, code_state > 0)
    if (length(unique_codes)==3 & any(unique_codes %in% 33)) {
      temp_sf <- subset(temp_sf, code_state ==33)
    }

    # Make any invalid geom valid
      # st_is_valid( temp_sf)
      temp_sf <- fix_topoly(temp_sf)

    # strange error in SC 2000
    # remove geometries with area == 0
    temp_sf <- temp_sf[ as.numeric(sf::st_area(temp_sf)) != 0, ]


    # simplify
    temp_sf_simplified <- simplify_temp_sf(temp_sf)

    # convert to MULTIPOLYGON
    temp_sf <- to_multipolygon(temp_sf)
    temp_sf_simplified <- to_multipolygon(temp_sf_simplified)

    # Make any invalid geom valid # st_is_valid( sf)
    temp_sf <- fix_topoly(temp_sf)
    temp_sf_simplified <- fix_topoly(temp_sf_simplified)


    # Save cleaned data --------------------------------

    # save each state separately
    for (c in unique(temp_sf$code_state)) { # c <- 28

      temp2 <- subset(temp_sf, code_state ==c)
      temp2_simplified <- subset(temp_sf_simplified, code_state ==c)

      file_name <- paste0(unique(substr(temp2$code_state,1,2)),"municipality_", year, ".gpkg")
      message(paste('saving', file_name))

      # original
      i <- paste0(dest_dir, '/', file_name)
      sf::st_write(temp2, i,
                   overwrite = TRUE, append = FALSE,
                   delete_dsn = T, delete_layer = T, quiet = T)

      # simplified
      i <- gsub(".gpkg", "_simplified.gpkg", i)
      sf::st_write(temp2_simplified, i,
                   overwrite = TRUE, append = FALSE,
                   delete_dsn = T, delete_layer = T, quiet = T)
    }

  }

  # clean all files
  pbapply::pblapply(X = files, FUN = clean_file)

  }