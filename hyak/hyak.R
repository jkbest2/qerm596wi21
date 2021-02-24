library(TMB)

tmb_ex <- runExample()

for (ex in tmb_ex) {
  runExample(ex)
  # obj and opt are created by `runExample`
  opt <- opt
  sdr <- sdreport(obj)
  saveRDS(list(opt = opt, sdr = sdr),
          paste0(ex, "_result.Rdata"))
}
