data {
  // Need the number of observations to declare shapes of data and parameters
  int nobs;
  int nlocations;
  // Response
  int ticks[nobs];
  // Alternative to three vectors here would be to pass a design matrix. brood
  // and location will be used as indices, so they need to be int vectors
  real cheight[nobs];
  int location[nobs];
}

transformed data {
  // Don't need this section for this model
}

parameters {
  real mu;                      // Intercept
  real delta;                   // Height effect
  real gamma[nlocations];       // Location effect
  // Important to declare bounds where appropriate. These are standard
  // deviations, so they must be positive!
  real<lower=0> sig_gamma;      // Location effect SD
}
transformed parameters {
  real log_lambda[nobs];        // Poisson log-rates

  for (i in 1:nobs) {
    // Using a vector of integers to index into a parameter vector is a common
    // pattern, as here with `gamma[location[i]]`; pick out the location effect
    // `gamma` of the location associated with the `i`th observation.
    log_lambda[i] = mu + delta * cheight[i] + gamma[location[i]];
  }
}
model {

  // Hyperpriors
  sig_gamma ~ exponential(10);

  // Priors
  mu ~ normal(1, 1.25);
  delta ~ normal(0, 0.5);
  gamma ~ normal(0, sig_gamma); // Note these are *vectorized*

  // Observation likelhood
  // Use the `poisson_log` function here for efficiency/numerical stability
  ticks ~ poisson_log(log_lambda);
}

generated quantities {
   // Generate new observations for posterior predictive checks
   int sim_ticks[nobs];
   sim_ticks = poisson_log_rng(log_lambda);
}
