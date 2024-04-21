#' @title Construct url request for data
#' @param station_id ID of weather station
#' @param time_step Frequency of data (5min, hourly, daily)
#' @param date_from Start date of data to get in yyyy-mm-dd format
#' @param date_to End date of data in yyyy-mm-dd format
#' @returns url to request data from CoAgMet API
#' @author Andy Pickering
#' @export

construct_data_url <- function(station_id="cht01", time_step="hourly", date_from="2024-04-10", date_to="now"){

  base_url <- "https://coagmet.colostate.edu/"

  date_str <- paste0("from=", date_from, "&to=", date_to)

  data_url <- paste0(base_url, 'data/',time_step ,'/',station_id,
                     ".csv?header=yes&", date_str,
                     "&fields=t,rh,dewpt,solarRad,precip,windSpeed,windDir,gustSpeed,gustTime,gustDir,st5cm,st15cm")

}
