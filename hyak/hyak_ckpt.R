library(TMB)

tmb_ex <- runExample()

for (ex in tmb_ex) {
  file <- paste0(ex, "_results.Rdata")
  ## Only run the fits if results don't exist
  if (!file.exists(file)) {
    runExample(ex)
    ## obj and opt are created by `runExample`
    opt <- opt
    sdr <- sdreport(obj)
    saveRDS(list(opt = opt, sdr = sdr),
            paste0(ex, "_result.Rdata"))
  }
}
