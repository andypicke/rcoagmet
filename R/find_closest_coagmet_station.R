#' @title Find closest CoAgMet station to given location (using Haversine formula)
#' @param xlat latitidue (degN)
#' @param xlon longitude (degE)
#' @returns closest_station: 1 row Dataframe of info for closest station, including distance in meters
#' @export
#' @author Andy Pickering



find_closest_coagmet_station <- function(xlat, xlon){

  # get all stations info
  stations <- rcoagmet::get_coagmet_meta()

  # distances between (xlon,xlat) and stations in meters
  dists <- geosphere::distHaversine(c(xlon,xlat), dplyr::bind_cols(stations$longitude_deg_e,stations$latitude_deg_n))

  imin <- which.min(dists)

  closest_station <- stations[imin,]
  closest_station$distance_m <- dists[imin]

  return(closest_station)

}


