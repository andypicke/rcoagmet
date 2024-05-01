#' @title Get and process CoAgMet data for one station
#' @param station_id ID of weather station; default 'cht01'
#' @param time_step Frequency of data (5min, hourly, daily); default 'hourly'
#' @param date_from Start date of data to get in yyyy-mm-dd format: default is 5 days ago
#' @param date_to End date of data in yyyy-mm-dd format; defaut 'now'
#' @returns Data frame of processed CoAgMet data for one station
#'
#' @export


get_coagmet_data_one_station <- function(station_id="cht01", time_step="hourly", date_from = lubridate::today() - 5, date_to = "now"){

  url <- rcoagmet::construct_data_url(station_id, time_step, date_from, date_to)

  df <- rcoagmet::fetch_coagmet_data_csv(url)

  if (time_step == "daily") {
    df_proc <- rcoagmet::process_coagmet_data_csv_daily(df)
  } else {
    df_proc <- rcoagmet::process_coagmet_data_csv(df)
  }

  return(df_proc)
}
