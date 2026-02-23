data {
  int<lower=1> K; // number of mixture components
  int<lower=1> N; // number of data points
  array[N] int y; // observations
}
parameters {
  
  simplex[K] prop; // mixing proportions, phi
  
  // array[K]real<lower=0, upper=1> theta; // success prob
  
  positive_ordered[K] lambda;
  
  
} transformed parameters{
  simplex[K] theta = lambda / sum(lambda);
}
model {
  array[K] real ps; // temp for log component densities

  prop ~ uniform(0, 1);
  lambda ~ gamma(1, 1);

  // theta ~ uniform(0, 1);

  //theta[1] ~ beta(5, 1);
  // theta[2] ~ beta(1, 5);

  for (n in 1:N) {


    for (k in 1:K) {
      ps[k] = log(prop[k])
      + binomial_lpmf(y[n] | 10, theta[k]);
    }
    target += log_sum_exp(ps);
  }
} 
