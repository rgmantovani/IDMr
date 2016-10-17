# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getData = function(filename) {

  dataset = read.csv(file = filename)
  class.idxs = grep("class", names(dataset)) 

  # Replacing X as a Missing Value (NA)
  for(id in class.idxs) {
    missing.ids = which(dataset[, id] == "X")
    dataset[missing.ids, id] = NA
    dataset[, id] = factor(dataset[, id])
  }

  return (dataset)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
