# Meta Ray-Ban Display - Bass Model Innovation Diffusion

DS 223 Marketing Analytics project.

## Innovation
**Meta Ray-Ban Display**, selected from TIME's Best Inventions of 2025.

## Historical look-alike
**Smartphones**, using global annual smartphone sales from Gartner via Statista.

## Scope
Global.

## Important data rule
This repository uses published observed data only. No historical values are fabricated. Any value produced by a formula or Bass Model is explicitly labeled as a **calculation**, **estimate**, **proxy**, or **forecast**.

## Repository structure

```text
meta-rayban-bass-model/
├── README.md
├── data/
│   ├── smartphone_sales_gartner_statista_2007_2020.csv
│   ├── display_glasses_market_idc.csv
│   └── product_meta_rayban_display.csv
├── img/
│   ├── historical_smartphone_sales.png
│   ├── smartphone_bass_fit.png
│   ├── idc_display_glasses_forecast.png
│   └── meta_rayban_display_diffusion.png
├── output/
│   ├── smartphone_bass_fit.csv
│   ├── model_parameters.csv
│   └── meta_rayban_display_bass_forecast.csv
├── report/
│   ├── report_source.Rmd
│   └── report.pdf
├── references/
│   └── references.md
└── scripts/
    ├── bass_model.R
    └── generate_forecast.R
```

## How to run in RStudio

From the repository root:

```r
install.packages(c("ggplot2", "rmarkdown"))
source("scripts/generate_forecast.R")
rmarkdown::render("report/report_source.Rmd")
```

## Main model approach

1. Estimate Bass `p`, `q`, and historical `M` from real global smartphone sales.
2. Transfer `p` and `q` to the new-product scenario as a look-alike assumption.
3. Use IDC's published optical see-through display-glasses forecast to create a transparent market-potential proxy instead of inventing a market-size number.
4. Forecast annual and cumulative adoption with the Bass Model.

## Sources
See `references/references.md`.
