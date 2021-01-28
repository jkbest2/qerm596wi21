data {
  // Need the number of observations to declare shapes of data and parameters
  int nobs;
  int nlocations;
  // Response
  ___ ticks[____];
  // Alternative to three vectors here would be to pass a design matrix. brood
  // and location will be used as indices, so they need to be int vectors
  ____ cheights[____];
  ___ locations[____];
}

transformed data {
  // Don't need this section for this model
}

parameters {
  real __;                      // Intercept
  ____ delta;                   // Height effect
  ____ gamma[__________];       // Location effect
  // Important to declare bounds where appropriate. These are standard
  // deviations, so they must be positive!
  real <lower=_> sig_gamma;      // Location effect SD
}

transformed parameters {
  ____ log_lambda[____];        // Poisson log-rates

  for (i in 1:____) {
    // Using a vector of integers to index into a parameter vector is a common
    // pattern, as here with `gamma[location[i]]`; pick out the location effect
    // `gamma` of the location associated with the `i`th observation.
    log_lambda[i] = mu + _____ * cheight[i] + gamma[location[i]];
  }
}

model {
  // Hyperpriors
  sig_gamma ~ ___________(__);

  // Priors
  mu ~ ______(_, ____);
  delta ~ ______(_, _);
  gamma ~ ______(_, _________); // Note these are *vectorized*

  // Observation likelhood
  // Use the `poisson_log` function here for efficiency/numerical stability
  ticks ~ poisson_log(__________);
}

generated quantities {
   // Generate new observations for posterior predictive checks
   int sim_ticks[nobs];
   sim_ticks = poisson_log_rng(log_lambda);
}
