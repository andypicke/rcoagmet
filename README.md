
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rcoagmet

<!-- badges: start -->

[![R-CMD-check](https://github.com/andypicke/rcoagmet/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/andypicke/rcoagmet/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of rcoagmet is to provide functions for downloading data from
[CoAgMet](https://coagmet.colostate.edu/) weather stations, using their
[Data API](https://coagmet.colostate.edu/data/doc.html).

## Installation

You can install the development version of rcoagmet from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("andypicke/rcoagmet")
```

## Example

Download metadata for all CoAgMet stations:

``` r
library(rcoagmet)

meta <- get_coagmet_meta()

head(meta)
#> # A tibble: 6 × 13
#>   station name        location       latitude_deg_n longitude_deg_e elevation_ft
#>   <chr>   <chr>       <chr>                   <dbl>           <dbl>        <dbl>
#> 1 akr02   Akron       USDA-ARS-GPRC            40.2           -103.         4537
#> 2 alt01   Ault        1 mi SE Ault             40.6           -105.         4910
#> 3 avn01   Avondale    1 mi SE Avond…           38.2           -104.         4630
#> 4 bla01   Blanca      8 mi SW Blanca           37.4           -106.         7755
#> 5 bnv01   Buena Vista CDW Area SW o…           38.8           -106.         7900
#> 6 brg01   Briggsdale  3 mi S Briggs…           40.6           -104.         4858
#> # ℹ 7 more variables: anemometer_height_m <dbl>, active <chr>,
#> #   irrigation <chr>, first_observation <chr>, last_observation <chr>,
#> #   timestep_s <dbl>, network <chr>
```

Get latest data from all stations:

``` r

latest <- get_coagmet_data(station_id = "all", time_step = "latest")

head(latest)
#> # A tibble: 6 × 15
#>   station date_and_time       air_temp    rh dewpoint solar_rad x5min_precip
#>   <chr>   <dttm>                 <dbl> <dbl>    <dbl>     <dbl>        <dbl>
#> 1 akr02   2024-05-06 07:00:00     58.5 0.254    23.2      257.            NA
#> 2 alt01   2024-05-06 07:00:00     50.5 0.336    22.9       99.7           NA
#> 3 avn01   2024-05-06 07:10:00     54.6 0.182    12.1      376              0
#> 4 bla01   2024-05-06 07:05:00     36.5 0.305     8.31     359              0
#> 5 bnv01   2024-05-06 07:10:00     33.2 0.429    13.0      301.             0
#> 6 brg01   2024-05-06 07:00:00     51.8 0.464    31.9       84.0           NA
#> # ℹ 8 more variables: hourly_precip <dbl>, wind <dbl>, wind_dir <dbl>,
#> #   gust_speed <dbl>, gust_dir <dbl>, x5cm_soil_temp <dbl>,
#> #   x15cm_soil_temp <dbl>, date <date>
```

Find closest CoAgMet station to a given point:

``` r

# coordinates for Denver
xlat <- 39.74
xlon <- -104.99

nearest_station <- find_closest_coagmet_station(xlat, xlon)
#> New names:
#> • `` -> `...1`
#> • `` -> `...2`

nearest_station
#> # A tibble: 1 × 14
#>   station name   location            latitude_deg_n longitude_deg_e elevation_ft
#>   <chr>   <chr>  <chr>                        <dbl>           <dbl>        <dbl>
#> 1 den01   Denver CSU Spur campus, H…           39.8            -105         5280
#> # ℹ 8 more variables: anemometer_height_m <dbl>, active <chr>,
#> #   irrigation <chr>, first_observation <chr>, last_observation <chr>,
#> #   timestep_s <dbl>, network <chr>, distance_m <dbl>
```

Download data for one station:

``` r

df <- get_coagmet_data(station_id = "den01")

head(df)
#> # A tibble: 6 × 14
#>   station date_and_time       air_temp    rh dewpoint solar_rad precip  wind
#>   <chr>   <dttm>                 <dbl> <dbl>    <dbl>     <dbl>  <dbl> <dbl>
#> 1 den01   2024-05-01 00:00:00     52.5 0.286     20.8      0         0  2.3 
#> 2 den01   2024-05-01 01:00:00     50.9 0.373     25.7      0         0  2.98
#> 3 den01   2024-05-01 02:00:00     50.0 0.395     26.3      0         0  2.12
#> 4 den01   2024-05-01 03:00:00     49.3 0.35      22.8      0         0  1.67
#> 5 den01   2024-05-01 04:00:00     49.1 0.333     21.4      0         0  2.67
#> 6 den01   2024-05-01 05:00:00     49.8 0.289     18.7      0.75      0  3.05
#> # ℹ 6 more variables: wind_dir <dbl>, gust_speed <dbl>, gust_dir <dbl>,
#> #   x5cm_soil_temp <dbl>, x15cm_soil_temp <dbl>, date <date>
```

Plot air temp:

``` r

df |>
  ggplot2::ggplot(ggplot2::aes(date_and_time, air_temp)) +
  ggplot2::geom_line()
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

Make an interactive plot of one variable with plotly:

``` r

#plot_coagmet_plotly(df, "air_temp")
```
