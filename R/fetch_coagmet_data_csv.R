#' @title fetch_coagmet_data_csv
#' @param data_url API url for data request
#' @description
#' Fetch csv data from CoAgMet API for specified url
#' @author Andy Pickering
#' @returns Data frame of CoAgMet data
#'
#' @export




#-------------------------------------
# function to get data from API
#-------------------------------------
fetch_coagmet_data_csv <- function(data_url) {
  df <- readr::read_csv(
    file = data_url,
    col_names = TRUE,
    na = "-999", # missing values aremarked as -999 in data
    show_col_types = FALSE
  )
}
