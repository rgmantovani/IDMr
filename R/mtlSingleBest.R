
mtlSingleBest = function(data) {

  temp = data[, c("Class_limiar", "Class_kmeans", "Class_svm")]

  aux = lapply(colnames(temp), function(column){

    truth = temp[, column]

    nad.n = length(which(truth == 'NAD'))
    ad.n  = length(which(truth == 'AD'))

    prob = matrix(data = 0, ncol = 2, nrow = length(truth))

    if(ad.n > nad.n) {
      prob[,1] = 1
    } else {
      prob[,2] = 1
    }
    colnames(prob) = c("prob.AD", "prob.NAD")

    resp.aux = lapply(1:nrow(prob), function(i){
      line = prob[i, ]
      return(names(which.max(line)))
    })

    response = factor(gsub(x = unlist(resp.aux), pattern = "prob.", replacement = ""), 
      levels = levels(truth))

    tpRate = measureTPR(truth = truth, response = response, positive = "AD")
    tnRate = measureTPR(truth = truth, response = response, positive = "NAD")
    auc = measureAUC(probabilites = prob[,1], truth = truth, negative = "NAD", positive = "AD")
    acc = measureACC(truth = truth, response = response)
    f1 = accMultiMeasures(pred = response, test = truth)[4]
    
    ret = c(acc, auc, f1, tpRate, tnRate)
    names(ret) = c("pred.accuracy", "auc", "fScore", "TPRate", "TNRate")
    return(ret)

  })

  df = as.data.frame(do.call("rbind", aux))
  df$seg = colnames(temp)

  return(df)
}

# --------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------
