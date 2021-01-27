data {
  // Need the number of observations to declare shapes of data and parameters
  int nobs;
  int nlocations;
  int nbroods;
  // Response
  int ticks[nobs];
  // Alternative to three vectors here would be to pass a design matrix. brood
  // and location will be used as indices, so they need to be int vectors
  real cheight[nobs];
  int location[nobs];
  int brood[nobs];
}

transformed data {
  // Don't need this section
}

parameters {
  real mu;                      // Intercept
  real delta;                   // Height effect
  real gamma[nlocations];       // Location effect
  real beta[nbroods];           // Brood effect
  // Important to declare bounds where appropriate. These are standard
  // deviations, so they must be positive!
  real<lower=0> sig_gamma;      // Location effect SD
  real<lower=0> sig_beta;       // Brood effect SD
}
transformed parameters {
  real log_lambda[nobs];        // Poisson log-rates

  for (i in 1:nobs) {
    log_lambda[i] = mu + delta * cheight[i] + gamma[location[i]] + beta[brood[i]];
  }
}
model {

  // Hyperpriors
  sig_gamma ~ normal(0, 1);
  sig_beta ~ normal(0, 1);

  // Priors
  mu ~ normal(1.1, 1);
  delta ~ normal(0, 1);
  gamma ~ normal(0, sig_gamma); // Note these are *vectorized*
  beta ~ normal(0, sig_beta);

  // Observation likelhood
  // Use the `poisson_log` function here for efficiency/numerical stability
  ticks ~ poisson_log(log_lambda);
}

generated quantities {
   // Generate new observations for posterior predictive checks
   int sim_ticks[nobs];
   sim_ticks = poisson_log_rng(log_lambda);
}
