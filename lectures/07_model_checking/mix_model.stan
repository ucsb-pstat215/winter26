data {
  int<lower=1> K; // number of mixture components
  int<lower=1> N; // number of data points
  array[N] real y; // observations
}
parameters {
  simplex[K] theta; // mixing proportions
  array[K] real mu; // locations of mixture components
  array[K] real<lower=0> sigma; // scales of mixture components
}
model {
  array[K] real ps; // temp for log component densities
  sigma ~ cauchy(0, 1);
  mu ~ normal(10, 1);
  for (n in 1:N) {
    for (k in 1:K) {
      ps[k] = log(theta[k])
      + normal_lpdf(y[n] | mu[k], sigma[k]);
    }
    target += log_sum_exp(ps);
  }
} generated quantities{
  array[N] real log_lik;
  array[K] real ps;
  for(n in 1:N) {
    log_lik[n] = 0;
    for (k in 1:K) {
      ps[k] = log(theta[k])
      + normal_lpdf(y[n] | mu[k], sigma[k]);
    }
    log_lik[n] += log_sum_exp(ps);
  }
}