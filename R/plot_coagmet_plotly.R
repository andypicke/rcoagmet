#' @title Make plotly plot of one variable
#' @param df  Dataframe of processed CoAgMet data
#' @param var_to_plot Variable to plot; default is air_temp
#' @returns g: Plotly plot object
#'
#' @export



plot_coagmet_plotly <- function(df, var_to_plot = "air_temp"){

  df_to_plot <- df |>
    dplyr::select(date_and_time, dplyr::all_of(var_to_plot)) |>
    dplyr::rename(xvar = date_and_time, yvar = var_to_plot)

  g <- plotly::plot_ly(data = df_to_plot, x = ~xvar, y = ~yvar) |>
    plotly::add_lines(name = var_to_plot) |>
    plotly::layout(
      title = glue::glue('{df$station[1]} : {var_to_plot}'),
      xaxis = list(title = "Date"),
      yaxis = list(title = var_to_plot)
    )

  return(g)

}
