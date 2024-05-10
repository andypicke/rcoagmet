#' @title Get and process CoAgMet weather station (csv) data
#' @param station_id ID of weather station. Default = 'cht01'. Use "all" to retrieve data for all stations
#' @param time_step Frequency of data (5min, hourly, daily, latest); default 'hourly'
#' @param date_from Start date of data to get in yyyy-mm-dd format: default is 5 days ago
#' @param date_to End date of data in yyyy-mm-dd format; defaut = 'now'
#' @param network Network :either "coagmet" or "nw" (northern water). Default is coagmet
#' @returns Data frame of processed CoAgMet data
#' @examples
#' df <- get_coagmet_data(station_id = "cht01", time_step = "daily")
#' @export


get_coagmet_data <- function(station_id="cht01", time_step="hourly", date_from = lubridate::today() - 5,
                             date_to = "now", network = "coagmet"){

  url <- rcoagmet::construct_data_url(station_id, time_step, date_from, date_to, network)

  df <- rcoagmet::fetch_coagmet_data_csv(url)

  if (time_step == "daily") {
    df_proc <- rcoagmet::process_coagmet_data_csv_daily(df)
  } else {
    df_proc <- rcoagmet::process_coagmet_data_csv(df)
  }

  return(df_proc)
}
