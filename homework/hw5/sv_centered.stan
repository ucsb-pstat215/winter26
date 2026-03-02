
data {
  int<lower=0> T;
  vector[T] y;
}
parameters {
  real mu;
  real<lower=-1, upper=1> phi;
  real<lower=0> sigma;
  vector[T] h;
}
model {
  // Priors
  mu ~ normal(-1, 1);
  phi ~ beta(20, 1.5); // informative prior for persistence near 1
  sigma ~ exponential(5);

  // Latent State (Centered)
  h[1] ~ normal(mu, sigma / sqrt(1 - phi^2));
  for (t in 2:T) {
    h[t] ~ normal(mu + phi * (h[t-1] - mu), sigma);
  }

  // Likelihood
  y ~ normal(0, exp(h / 2));
}

