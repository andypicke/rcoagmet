#' @title Get Metadata for CoAgMet Weather Stations
#' @param station_id ID of station to retrieve info for. Default is all stations
#' @param network Network :either "coagmet" or "nw" (northern water). Default is coagmet
#' @returns Data frame of metadata for all CoAgMet Weather Stations
#' @examples
#' meta <- get_coagmet_meta()
#'
#' @export


get_coagmet_meta <- function(station_id = "all", network = "coagmet") {

  if (network == "coagmet") {
    file_url <- "https://coagmet.colostate.edu/data/metadata.csv?header=yes"
  } else if (network == "nw") {
    file_url <- "https://coagmet.colostate.edu/data/nw/metadata.csv?header=yes"
  } else {
    stop("network must be 'coagmet' or 'nw' ")
  }

  meta <- readr::read_csv(
    file = file_url,
    show_col_types = FALSE) |>
    janitor::clean_names()

  if (station_id != "all") {
    meta <- meta |> dplyr::filter("station" == station_id)
  }

  return(meta)
}
