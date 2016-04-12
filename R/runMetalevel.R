# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

runMetaLevel = function(dataset = dataset) {

  # 1 - Defining a multilabel task
  target.names = colnames(dataset)[grep("Class", colnames(dataset))]

  # targets must be logical, So (AD converts to TRUE and NAD to FALSE)
  for(target in target.names) {
    temp = as.character(dataset[, target])
    true.ids = which(temp == "AD")
    temp[true.ids] = "TRUE"
    temp[-true.ids] = "FALSE"
    dataset[, target] = as.logical(temp)
  }

  # data = dataset - first column
  task = makeMultilabelTask(data = dataset[2:ncol(dataset)], target = target.names)
  task = removeConstantFeatures(task)

  # 2. Defining the evaluating measures
  possible.measures = listMeasures(task)
  meas = lapply(possible.measures, get)

  # 3. Deining the learners
  learners = getMultilabelLearners()

  # 4. defining resampling strategy (Leave-One-Out)
  rdesc = makeResampleDesc(method = "LOO")

  # 5. Runing exrperiment 
  obj = benchmark(learners = learners, tasks = task, resamplings = rdesc, measures = meas)
 
  return(obj)

}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
