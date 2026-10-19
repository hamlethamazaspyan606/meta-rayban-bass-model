# Bass Model functions

bass_f <- function(t, p, q) {
  ((p + q)^2 / p) * exp(-(p + q) * t) /
    (1 + (q / p) * exp(-(p + q) * t))^2
}

bass_F <- function(t, p, q) {
  (1 - exp(-(p + q) * t)) /
    (1 + (q / p) * exp(-(p + q) * t))
}
