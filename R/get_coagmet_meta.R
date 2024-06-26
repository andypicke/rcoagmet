#' @title Get Metadata for CoAgMet Weather Stations
#' @param station_id ID of station to retrieve info for. Default is all stations
#' @param network Network : "coagmet", "nw" (northern water), or "both". Default is coagmet
#' @returns Data frame of metadata for all CoAgMet Weather Stations
#' @examples
#' meta <- get_coagmet_meta()
#'
#' @export


get_coagmet_meta <- function(station_id = "all", network = c("coagmet", "nw", "both")) {

  network <- match.arg(network)

  if (network == "coagmet") {

    file_url <- "https://coagmet.colostate.edu/data/metadata.csv?header=yes"
    meta <- fetch_coagmet_data_csv(file_url) |>
      janitor::clean_names()

  } else if (network == "nw") {

    file_url <- "https://coagmet.colostate.edu/data/nw/metadata.csv?header=yes"
    meta <- fetch_coagmet_data_csv(file_url) |>
      janitor::clean_names()

  } else if (network == "both") {

    file_url1 <- "https://coagmet.colostate.edu/data/metadata.csv?header=yes"
    meta1 <- fetch_coagmet_data_csv(file_url1) |>
      janitor::clean_names()

    file_url2 <- "https://coagmet.colostate.edu/data/nw/metadata.csv?header=yes"
    meta2 <- fetch_coagmet_data_csv(file_url2) |>
      janitor::clean_names()

    meta <- rbind(meta1, meta2)

  }


  if (station_id != "all") {
    meta <- meta[meta$station == station_id, ]
  }

  return(meta)
}
