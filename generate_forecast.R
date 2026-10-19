# DS 223 - Marketing Analytics
# Bass Model project: Meta Ray-Ban Display
# Historical look-alike: worldwide smartphone sales

library(ggplot2)
source("bass_model.R")

# 1. Historical smartphone sales data (Gartner via Statista)
smart <- read.csv("data/smartphone_sales_gartner_statista_2007_2020.csv")
sales <- smart$sales_million_units
t <- 1:length(sales)

# 2. Estimate Bass parameters with nonlinear least squares
# Same continuous-time Bass sales-rate formulation used in the course lecture.
bass_m <- nls(
  sales ~ m * (((p + q)^2 / p) * exp(-(p + q) * t)) /
    (1 + (q / p) * exp(-(p + q) * t))^2,
  start = list(m = sum(sales), p = 0.02, q = 0.4)
)

params <- coef(bass_m)
m_hist <- unname(params["m"])
p_est <- unname(params["p"])
q_est <- unname(params["q"])

print(summary(bass_m))

# Historical fitted values
smart$predicted_sales_million <- predict(bass_m)
write.csv(smart, "output/smartphone_bass_fit.csv", row.names = FALSE)

# 3. Data-based market-potential proxy for display glasses
# IDC publishes 3.0M units for 2026 and 12.2M for 2030,
# with a 41.9% CAGR. Intermediate years are transparent calculations.
# Because IDC reports annual shipments rather than unique lifetime adopters,
# the cumulative 2026-2030 shipments are used only as a MODELING PROXY for M.
idc <- read.csv("data/display_glasses_market_idc.csv")
M_new <- sum(idc$shipments_million_units)

# 4. Forecast diffusion path using p and q from smartphones
forecast_t <- 1:15
forecast_year <- 2025 + forecast_t
forecast <- data.frame(
  year = forecast_year,
  t = forecast_t,
  predicted_new_adopters_million = M_new * bass_f(forecast_t, p_est, q_est),
  predicted_cumulative_adopters_million = M_new * bass_F(forecast_t, p_est, q_est)
)
write.csv(forecast, "output/meta_rayban_display_bass_forecast.csv", row.names = FALSE)

# 5. Parameter table
parameter_table <- data.frame(
  parameter = c("p", "q", "M_historical_million", "M_new_proxy_million"),
  value = c(p_est, q_est, m_hist, M_new),
  explanation = c(
    "Coefficient of innovation estimated from worldwide smartphone sales",
    "Coefficient of imitation estimated from worldwide smartphone sales",
    "Historical smartphone market potential from NLS Bass fit",
    "Modeling proxy: cumulative IDC OST display-glasses shipments, 2026-2030"
  )
)
write.csv(parameter_table, "output/model_parameters.csv", row.names = FALSE)

# 6. Charts
g1 <- ggplot(smart, aes(year, sales_million_units)) +
  geom_col() +
  labs(title = "Global Smartphone Sales", y = "Million units", x = "Year") +
  theme_minimal()
ggsave("img/historical_smartphone_sales.png", g1, width = 8, height = 5, dpi = 160)

g2 <- ggplot(smart, aes(year)) +
  geom_col(aes(y = sales_million_units), alpha = 0.6) +
  geom_line(aes(y = predicted_sales_million), linewidth = 1) +
  geom_point(aes(y = predicted_sales_million), size = 1.6) +
  labs(title = "Smartphone Sales and Bass Model Fit", y = "Million units", x = "Year") +
  theme_minimal()
ggsave("img/smartphone_bass_fit.png", g2, width = 8, height = 5, dpi = 160)

g3 <- ggplot(idc, aes(year, shipments_million_units)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  labs(
    title = "Optical See-Through Display Glasses: IDC Forecast",
    subtitle = "2027-2029 calculated from IDC's published 41.9% CAGR",
    y = "Million units", x = "Year"
  ) +
  theme_minimal()
ggsave("img/idc_display_glasses_forecast.png", g3, width = 8, height = 5, dpi = 160)

g4 <- ggplot(forecast, aes(year, predicted_new_adopters_million)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  labs(
    title = "Meta Ray-Ban Display: Bass-Model Diffusion Scenario",
    subtitle = "p and q from smartphone data; M is an IDC-based modeling proxy",
    y = "Predicted new adopters (million)", x = "Year"
  ) +
  theme_minimal()
ggsave("img/meta_rayban_display_diffusion.png", g4, width = 8, height = 5, dpi = 160)

cat("Estimated p:", p_est, "\n")
cat("Estimated q:", q_est, "\n")
cat("Historical fitted M (million):", m_hist, "\n")
cat("New-product M proxy (million):", M_new, "\n")
cat("Peak period:", log(q_est / p_est) / (p_est + q_est), "\n")
