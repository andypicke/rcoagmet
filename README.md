
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rcoagmet

<!-- badges: start -->

[![R-CMD-check](https://github.com/andypicke/rcoagmet/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/andypicke/rcoagmet/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of [rcoagmet](#rcoagmet)(emberr
(<https://github.com/andypicke/emberr>) is to provide functions for
downloading data from [CoAgMet](https://coagmet.colostate.edu/) weather
stations, using their [Data
API](https://coagmet.colostate.edu/data/doc.html).

See also this [blog
post](https://andypicke.quarto.pub/portfolio/posts/rcoagmet/rcoagmet.html)
describing the package and showing some examples.

# Installation

You can install the development version of rcoagmet from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("andypicke/rcoagmet")
```

# Examples

## Download metadata for all CoAgMet stations:

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

## Download metadata for all Norther water stations:

``` r

meta <- get_coagmet_meta(network = "nw")

head(meta)
#> # A tibble: 6 × 13
#>   station name              location latitude_deg_n longitude_deg_e elevation_ft
#>   <chr>   <chr>             <chr>             <dbl>           <dbl>        <dbl>
#> 1 bld01   Boulder South We… Fairvie…           40.0           -105.         5515
#> 2 bld02   Boulder North We… Foothil…           40.0           -105.         5561
#> 3 bru01   Brush             1 mile …           40.3           -103.         4215
#> 4 btd01   Berthoud          Norther…           40.3           -105.         5069
#> 5 crk01   Crook             3 miles…           40.8           -102.         3735
#> 6 eat01   Eaton             3 miles…           40.6           -104.         4900
#> # ℹ 7 more variables: anemometer_height_m <dbl>, active <chr>,
#> #   irrigation <chr>, first_observation <chr>, last_observation <chr>,
#> #   timestep_s <dbl>, network <chr>
```

## Get latest data from all CoAgMet stations:

``` r

latest <- get_coagmet_data(station_id = "all", time_step = "latest")

head(latest)
#> # A tibble: 6 × 15
#>   station date_and_time       air_temp    rh dewpoint solar_rad x5min_precip
#>   <chr>   <dttm>                 <dbl> <dbl>    <dbl>     <dbl>        <dbl>
#> 1 akr02   2024-05-14 08:00:00     61.2 0.604     47.3      447.           NA
#> 2 alt01   2024-05-14 08:00:00     63.6 0.442     41.4      405.           NA
#> 3 avn01   2024-05-14 08:50:00     67.9 0.471     47.0      416.            0
#> 4 bla01   2024-05-14 08:55:00     56.7 0.43      34.4      677             0
#> 5 bnv01   2024-05-14 08:50:00     56.9 0.408     33.3      711.            0
#> 6 brg01   2024-05-14 08:00:00     63.3 0.479     43.2      243.           NA
#> # ℹ 8 more variables: hourly_precip <dbl>, wind <dbl>, wind_dir <dbl>,
#> #   gust_speed <dbl>, gust_dir <dbl>, x5cm_soil_temp <dbl>,
#> #   x15cm_soil_temp <dbl>, date <date>
```

## Find closest CoAgMet station to a given point:

``` r

# coordinates for Denver
xlat <- 39.74
xlon <- -104.99

nearest_station <- find_closest_coagmet_station(xlat, xlon)

nearest_station
#> # A tibble: 1 × 14
#>   station name   location            latitude_deg_n longitude_deg_e elevation_ft
#>   <chr>   <chr>  <chr>                        <dbl>           <dbl>        <dbl>
#> 1 den01   Denver CSU Spur campus, H…           39.8            -105         5280
#> # ℹ 8 more variables: anemometer_height_m <dbl>, active <chr>,
#> #   irrigation <chr>, first_observation <chr>, last_observation <chr>,
#> #   timestep_s <dbl>, network <chr>, distance_m <dbl>
```

## Download data for one station:

``` r

df <- get_coagmet_data(station_id = "den01")

head(df)
#> # A tibble: 6 × 14
#>   station date_and_time       air_temp    rh dewpoint solar_rad precip  wind
#>   <chr>   <dttm>                 <dbl> <dbl>    <dbl>     <dbl>  <dbl> <dbl>
#> 1 den01   2024-05-09 00:00:00     48.2 0.262     15.1      0         0  1.93
#> 2 den01   2024-05-09 01:00:00     48   0.255     14.3      0         0  2.15
#> 3 den01   2024-05-09 02:00:00     47.8 0.255     14.1      0         0  1.28
#> 4 den01   2024-05-09 03:00:00     47.2 0.284     16.1      0         0  0.68
#> 5 den01   2024-05-09 04:00:00     46.3 0.329     18.7      0         0  1.65
#> 6 den01   2024-05-09 05:00:00     46.2 0.347     19.8      0.82      0  3.1 
#> # ℹ 6 more variables: wind_dir <dbl>, gust_speed <dbl>, gust_dir <dbl>,
#> #   x5cm_soil_temp <dbl>, x15cm_soil_temp <dbl>, date <date>
```

### Plot air temp:

``` r

df |>
  ggplot2::ggplot(ggplot2::aes(date_and_time, air_temp)) +
  ggplot2::geom_line()
```

<img src="man/figures/README-unnamed-chunk-7-1.png" width="100%" />

### Make an interactive plot of one variable with plotly:

``` r

#plot_coagmet_plotly(df, "air_temp")
```
