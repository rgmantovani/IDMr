# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

  devtools::load_all()

  # filename = "data/feridas.csv"
  # filename = "data/nuvem.csv"
  # filename = "data/frango_edited.csv"
  # filename = "data/berkeley_jenks.csv"
  filename = "data/all.csv"
  dataset = getData(filename = filename)

   # 1 - Defining a multilabel task
  target.names = colnames(dataset)[grep("class", colnames(dataset))]

  # targets must be logical, So (AD converts to TRUE and NAD to FALSE)
  for(target in target.names) {
    temp = as.character(dataset[, target])
    true.ids = which(temp == "AD")
    temp[true.ids] = "TRUE"
    temp[-true.ids] = "FALSE"
    dataset[, target] = as.logical(temp)
  }

  # data = not using the first column
  task = makeMultilabelTask(data = dataset[2:ncol(dataset)], target = target.names)
  task = removeConstantFeatures(task)

  # 2. Defining the evaluating measures
  possible.measures = listMeasures(task)
  meas = lapply(possible.measures, get)

  # 3. Deining the learners
  learners = getMultilabelLearners()

  # 4. defining resampling strategy
  rdesc = makeResampleDesc(method = "CV", iters = 10, stratify = FALSE)

  # 5. Runing exrperiment (just NB) 
  obj = benchmark(learners = learners[[7]], tasks = task, resamplings = rdesc, measures = meas)
 
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
  
  print(" - Aggregated performances")
  print(aggr)
 
  print(" - Benchmark results ")
  print(temp)


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------