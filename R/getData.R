# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getData = function(filename) {

  dataset = read.csv(file = filename)
  class.idxs = (ncol(dataset)-2):ncol(dataset)
  colnames(dataset)[class.idxs] = paste0("Class_", colnames(dataset)[class.idxs])  
 
  # Replacing X as a Missing Value (NA)
  for(id in class.idxs) {
    missing.ids = which(dataset[, id] == "X")
    dataset[missing.ids, id] = NA
    dataset[, id] = factor(dataset[, id])
  }

  # Calling data pre-processing step
  new.dataset = dataPreprocessing(dataset = dataset)
  return(new.dataset)

}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

dataPreprocessing = function(dataset) {

  # Replacing Missing Values (numeric values by the mean, factor by the mode)
  if (any(is.na(dataset))) {
    catf("  * Data imputation required ...")
    temp = impute(data = dataset, classes = list(numeric = imputeMean(), factor = imputeMode()))
    new.dataset = temp$data
  } else {
    catf("  * No data imputation required (no missing values) ...  ")
    new.dataset = dataset
  }

  return(new.dataset)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
