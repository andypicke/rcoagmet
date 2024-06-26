#' @title Find closest CoAgMet station to given location (using Haversine formula)
#' @param xlat latitidue (degN)
#' @param xlon longitude (degE)
#' @param network Network :either "coagmet" or "nw" (northern water). Default is coagmet
#' @returns closest_station: 1 row Dataframe of info for closest station, including distance in meters
#' @examples
#' closest <- find_closest_coagmet_station(xlat = 39.74, xlon = -104.99)
#'
#' @export



find_closest_coagmet_station <- function(xlat, xlon, network = c("coagmet", "nw")){

  # check input
  network = match.arg(network)

  # get all stations info
  stations <- rcoagmet::get_coagmet_meta(network = network)

  # distances between (xlon,xlat) and stations in meters
  dists <- geosphere::distHaversine(c(xlon,xlat), stations[c("longitude_deg_e","latitude_deg_n")])

  imin <- which.min(dists)

  closest_station <- stations[imin,]
  closest_station$distance_m <- dists[imin]

  return(closest_station)

}


