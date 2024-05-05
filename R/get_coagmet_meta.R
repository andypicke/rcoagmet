#' @title Get Metadata for CoAgMet Weather Stations
#' @param station_id ID of station to retrieve info for. Default is all stations
#' @returns Data frame of metadata for all CoAgMet Weather Stations
#' @examples
#' meta <- get_coagmet_meta()
#'
#' @export


get_coagmet_meta <- function(station_id = "all") {
  meta <- readr::read_csv(
    file = "https://coagmet.colostate.edu/data/metadata.csv?header=yes",
    show_col_types = FALSE) |>
    janitor::clean_names()

  if (station_id != "all") {
    meta <- meta |> dplyr::filter("station" == station_id)
  }

  return(meta)
}
