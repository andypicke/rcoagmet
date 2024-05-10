#' @title Construct URL request for data
#' @param station_id ID of weather station; default 'cht01'. Use 'all' to get data for all stations
#' @param time_step Frequency of data (5min, hourly, daily, latest); default 'hourly'
#' @param date_from Start date of data to get in yyyy-mm-dd format: default is 5 days ago
#' @param date_to End date of data in yyyy-mm-dd format; defaut 'now'
#' @param network Network :either "coagmet" or "nw" (northern water). Default is coagmet
#' @returns data_url : UR to request data from CoAgMet API
#' @examples
#' url <- construct_data_url()
#'
#' @export

construct_data_url <- function(station_id = "cht01",
                               time_step = "hourly",
                               date_from = lubridate::today() - 5,
                               date_to = "now",
                               network = "coagmet") {

  base_url <- "https://coagmet.colostate.edu/"

  date_str <- paste0("from=", date_from, "&to=", date_to)

  # coagmet or norther water stations
  if (network == "coagmet") {
    network_str <- ""
  } else if (network == "nw") {
    network_str <- "nw/"
  }  else {
    stop("network must be 'coagmet' or 'nw' ")
  }

  # build complete URL for API request
  if (station_id == "all") {
    data_url <- paste0(
      base_url, "data/", network_str, time_step,
      ".csv?header=yes&", date_str)
  } else {
    data_url <- paste0(
      base_url, "data/", network_str, time_step, "/", station_id,
      ".csv?header=yes&", date_str)
  }

  return(data_url)

}
