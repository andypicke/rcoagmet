#' @title Get Metadata for CoAgMet Weather Stations
#' @param station_id ID of station to retrieve info for. Default is all stations
#' @param network Network :either "coagmet" or "nw" (northern water). Default is coagmet
#' @returns Data frame of metadata for all CoAgMet Weather Stations
#' @examples
#' meta <- get_coagmet_meta()
#'
#' @export


get_coagmet_meta <- function(station_id = "all", network = c("coagmet", "nw")) {

  network <- match.arg(network)

  if (network == "coagmet") {
    file_url <- "https://coagmet.colostate.edu/data/metadata.csv?header=yes"
  } else if (network == "nw") {
    file_url <- "https://coagmet.colostate.edu/data/nw/metadata.csv?header=yes"
  }


  meta <- fetch_coagmet_data_csv(file_url) |>
    janitor::clean_names()

  if (station_id != "all") {
    meta <- meta[meta$station == station_id, ]
  }

  return(meta)
}
