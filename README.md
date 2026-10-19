# Meta Ray-Ban Display - Bass Model Innovation Diffusion

**Student:** Hamlet Hamazaspyan  
**Course:** Marketing Analytics / DS 223  
**2025 innovation:** Meta Ray-Ban Display  
**Historical look-alike:** Smartphones  
**Scope:** Worldwide

## Data integrity
Observed input data come from published sources. Values created by formulas are labeled as calculations, estimates, proxies, or forecasts. The IDC-based value used for the new-product `M` is explicitly a modeling proxy, because IDC publishes annual shipment forecasts rather than a lifetime unique-adopter market potential.

## Repository structure

```text
meta-rayban-bass-model/
├── README.md
├── bass_model.R
├── generate_forecast.R
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
└── report/
    ├── report_source.Rmd
    └── report.pdf
```

## How to run in RStudio
Set the working directory to the repository root, then run:

```r
install.packages(c("ggplot2", "rmarkdown"))
source("generate_forecast.R")
rmarkdown::render("report/report_source.Rmd")
```

## Method
1. Estimate Bass `p`, `q`, and historical `M` from worldwide smartphone sales using nonlinear least squares.
2. Transfer `p` and `q` to the new-product scenario as a historical look-alike assumption.
3. Use IDC's published optical see-through display-glasses forecast as evidence for a transparent `M` proxy rather than inventing a market-size number.
4. Forecast annual and cumulative adoption using the Bass Model.

## Main sources
- TIME (2025), *Meta Ray-Ban Display: The Best Inventions of 2025*.
- Gartner via Statista, *Global smartphone sales to end users*.
- IDC (2026), *Augmented and Virtual Reality Headsets Market Insights* and *Smart Glasses Surge: The XR Market Is Rewriting Its Own Rules*.
- Karen Hovhannisyan, DS 223 Marketing Analytics course lecture and Bass Model assignment.
