# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# References: 
# - https://mlr-org.github.io/mlr-tutorial/devel/html/multilabel/index.html
# - https://www.kaggle.com/wiki/HammingLoss

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

main = function() {

  devtools::load_all()

  data.files = list.files(path = "data", pattern = ".csv$", full.names = TRUE)
 
  # Running for all the bases
  aux = lapply(data.files, function(file){
    
    filename = gsub("data/", "", gsub("*.csv", "", file))
    cat("# Running base: ", filename, "\n")
    
    dataset = getData(filename = file)
    catf("   - data read")
    
    obj = runMetaLevel(dataset = dataset, filename = filename)
    catf("   - meta-level done")
        
    # Aggregated multilabel measures (Hamming loss)
    aggr = getBMRAggrPerformances(obj, as.df=TRUE)
    aggr$task.id = filename

    # Acc, AUC and f-Measure, TP, TN, FP, FN for the binary tasks
    temp = lapply(getBMRPredictions(obj)[[1]], function(preds){
      perf = getMultilabelBinaryPerformances(preds, measures = list(acc, auc, f1, tp, tn, fp, fn))
      perf = as.data.frame(perf)
      perf$base = filename
      return(perf)
    })

    temp = do.call("rbind", temp)
    ret = list(aggr.results = aggr, br.results = temp)
    
    #saving results
    saveResults(obj = obj, prefix = filename)
    catf("   - results saved")
    
    return(ret)
  })

  # Save CSV files with average results
  summarizeResults(ret.list = aux)
  catf("Done !!!")

}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

main()

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------