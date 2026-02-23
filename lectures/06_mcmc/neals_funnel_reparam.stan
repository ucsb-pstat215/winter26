parameters {
  real y_raw; //Transformed paramters, well behaved geometry
  vector[9] x_raw;
}
transformed parameters { // deterministic fn of parameters
  real y;
  vector[9] x;

  y = 3.0 * y_raw;
  x = exp(y/2) * x_raw;
}
model {
  y_raw ~ std_normal(); // implies y ~ normal(0, 3)
  x_raw ~ std_normal(); // implies x ~ normal(0, exp(y/2))
}

