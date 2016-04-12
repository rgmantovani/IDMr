# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

saveResults = function(obj, prefix) {

  #check if exists the output subdir, if not, creates
  if(!dir.exists("output/")) {
    dir.create("output")
  }

  #save the file, and save a csv of the df result
  save(obj, file = paste0("output/", prefix, ".RData"))

}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

summarizeResults = function(ret.list) {

  # join the f
  df1 = lapply(ret.list, function(elem){
    return(elem$aggr.results)
  })
  df1 = do.call("rbind", df1)

  df2 = lapply(ret.list, function(elem){
    return(elem$br.results)
  })
  df2 = do.call("rbind", df2)
  df2$algo = rownames(df2)
  rownames(df2) = NULL

  write.csv(df1, file = "output/aggregated-multi-label-results.csv")
  write.csv(df2, file = "output/binary-relevance-tasks-results.csv")

}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# mergeBenchmarkResultLearner(bmr, bmr2)/

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------