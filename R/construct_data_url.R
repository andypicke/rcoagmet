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
                               time_step = c("hourly", "5min", "daily", "latest"),
                               date_from = lubridate::today() - 5,
                               date_to = "now",
                               network = c("coagmet", "nw")) {

  # check inputs
  network = match.arg(network)
  time_step = match.arg(time_step)

  base_url <- "https://coagmet.colostate.edu/"

  if (time_step == "latest") {
    date_str <- ""
  } else {
    date_str <- paste0("&from=", date_from, "&to=", date_to)
  }

  # includes rso field that is not returned by default
  if (time_step == "daily") {
    data_fields_str <- "&fields=tAvg,tMax,tMaxTime,tMin,tMinTime,rhMax,rhMaxTime,rhMin,rhMinTime,precip,windRun,gustSpeed,gustTime,gustDir,solarRad,rso,etrASCE,etrPK,etrHourly,etoASCE,st5Max,st5MaxTime,st5Min,st5MinTime,st15Max,st15MaxTime,st15Min,st15MinTime"
  } else {
    data_fields_str <- "&fields=t,rh,dewpt,solarRad,rso,precip,windSpeed,windDir,gustSpeed,gustDir,st5cm,st15cm"
  }

  # coagmet or norther water stations
  if (network == "coagmet") {
    network_str <- ""
  } else if (network == "nw") {
    network_str <- "nw/"
  }

  # build complete URL for API request
  if (station_id == "all") {
    data_url <- paste0(
      base_url, "data/", network_str, time_step,
      ".csv?header=yes", date_str, data_fields_str)
  } else {
    data_url <- paste0(
      base_url, "data/", network_str, time_step, "/", station_id,
      ".csv?header=yes", date_str, data_fields_str)
  }

  return(data_url)

}
