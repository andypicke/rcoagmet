#' @title Download CoAgMet data (csv) for specified url
#' @param data_url API url for data request
#' @returns Data frame of requested CoAgMet data
#' @seealso [construct_data_url()]
#' @export




#-------------------------------------
# function to get data from API
#-------------------------------------
fetch_coagmet_data_csv <- function(data_url) {

  resp <- httr::GET(data_url, httr::user_agent("rcoagmet (https://github.com/andypicke/rcoagmet)"))

  # check if successful response code returned
  if (resp$status_code != 200) {
    stop(paste("API returned not 200 status code: ", resp$status_code))
  }

  #parse response
  resp_parsed <- httr::content(resp, as = "text")

  df <- readr::read_csv(
    file = resp_parsed,
    col_names = TRUE,
    na = "-999", # missing values ar emarked as -999 in data
    show_col_types = FALSE
  )

}
