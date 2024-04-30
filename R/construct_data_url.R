#' @title Construct url request for data
#' @param station_id ID of weather station; default 'cht01'. Use 'all' to get data for all stations
#' @param time_step Frequency of data (5min, hourly, daily); default 'hourly'
#' @param date_from Start date of data to get in yyyy-mm-dd format: default is 5 days ago
#' @param date_to End date of data in yyyy-mm-dd format; defaut 'now'
#' @returns url to request data from CoAgMet API
#' @author Andy Pickering
#' @export

construct_data_url <- function(station_id = "cht01", time_step = "hourly", date_from = lubridate::today() - 5, date_to = "now") {
  base_url <- "https://coagmet.colostate.edu/"

  date_str <- paste0("from=", date_from, "&to=", date_to)

  if (time_step == "daily") {
    fields_str <- ""
  } else {
    fields_str <- "&fields=t,rh,dewpt,solarRad,precip,windSpeed,windDir,gustSpeed,gustTime,gustDir,st5cm,st15cm"
  }

  if (station_id == "all") {
    data_url <- paste0(
      base_url, "data/", time_step,
      ".csv?header=yes&", date_str, fields_str
    )
  } else {
    data_url <- paste0(
      base_url, "data/", time_step, "/", station_id,
      ".csv?header=yes&", date_str, fields_str
    )
  }
}
