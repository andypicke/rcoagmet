#' @title Process CoAgMet data returned from API
#' @param df Data frame of CoAgMet data as returned by fetch_coagmet_data_csv.R
#' @returns Processed data frame of CoAgMet data
#' @export


process_coagmet_data_csv <- function(df){

  # clean names
  df <- df |> janitor::clean_names()

  # 1st row of (2nd row in raw csv data) is the units for each column

  # save units
  units <- df[1,]

  # then remove units row from dataframe
  df2 <- df[-1,]

  # convert datetimes, fix timezone, add date etc
  df2$date_and_time <- lubridate::mdy_hm(df2$date_and_time)
  df2$date_and_time <- lubridate::force_tz(time = df2$date_and_time, tzone = "MST") # by default API returns times in MST (UTC-7)
  df2$date <- lubridate::date(x = df2$date_and_time)

  df2$gust_time2 <- lubridate::ymd_hm(paste(df2$date, df2$gust_time))

  # convert data columns from character to numeric
  df2 <- df2 |>
    dplyr::mutate(dplyr::across(-c('station', 'date_and_time', 'date', 'gust_time', 'gust_time2'),
                                as.numeric)
    )

  return(df2)
  #return(list(df2, units))

}
