#' @title Process daily CoAgMet (csv) data returned from API
#' @param df Data frame of CoAgMet data as returned by fetch_coagmet_data_csv.R
#' @returns Processed data frame of daily CoAgMet data
#' @seealso [fetch_coagmet_data_csv()]
#' @export

process_coagmet_data_csv_daily <- function(df) {
  # clean names
  df <- df |> janitor::clean_names()

  # 1st row of (2nd row in raw csv data) is the units for each column

  # save units
  units <- df[1, ]

  # then remove units row from dataframe
  df2 <- df[-1, ]

  # convert datetimes, fix timezone, add date etc
  df2$date <- lubridate::mdy(df2$date)

  # convert gust time into date-time format
  df2$gust_datetime <- lubridate::ymd_hm(paste(df2$date, df2$gust_time))

  #  convert data columns from character to numeric
  df2 <- df2 |>
    dplyr::mutate(dplyr::across(
      -c("station", "date", "gust_time", "gust_datetime", dplyr::ends_with('_time')),
      as.numeric
    ))


  return(df2)
}
