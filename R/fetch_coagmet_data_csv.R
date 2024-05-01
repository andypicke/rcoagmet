#' @title Download CoAgMet data (csv) for specified url
#' @param data_url API url for data request
#' @returns Data frame of requested CoAgMet data
#' @seealso [construct_data_url()]
#' @export




#-------------------------------------
# function to get data from API
#-------------------------------------
fetch_coagmet_data_csv <- function(data_url) {
  df <- readr::read_csv(
    file = data_url,
    col_names = TRUE,
    na = "-999", # missing values ar emarked as -999 in data
    show_col_types = FALSE
  )
}
