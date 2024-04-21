#' @title Get Metadata for CoAgMet Weather Stations
#' @returns Data frame of metadata for all CoAgMet Weather Stations
#' @export
#'

get_coagmet_meta <- function(){
  meta <- readr::read_csv(file = "https://coagmet.colostate.edu/data/metadata.csv?header=yes") |>
    janitor::clean_names()
  return(meta)
}
