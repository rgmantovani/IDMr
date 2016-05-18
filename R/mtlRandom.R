# --------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------

mtlRandom = function(data, repetitions = 30) {

  temp = data[, c("Class_limiar", "Class_kmeans", "Class_svm")]

  aux = lapply(1:repetitions, function(i){
   
    inner.aux = lapply(colnames(temp), function(column){

      truth = temp[, column]
      tmp = runif( n = length(truth))
      prob = cbind(tmp, (1 - tmp))
      colnames(prob) = c("prob.AD", "prob.NAD")

      resp.aux = lapply(1:nrow(prob), function(i){
        line = prob[i, ]
        return(names(which.max(line)))
      })

      response = factor(gsub(x = unlist(resp.aux), pattern = "prob.", replacement = ""))

      tpRate = measureTPR(truth = truth, response = response, positive = "AD")
      tnRate = measureTPR(truth = truth, response = response, positive = "NAD")
      auc = measureAUC(probabilites = prob[,1], truth = truth, negative = "NAD", positive = "AD")
      acc = measureACC(truth = truth, response = response)
      f1 = accMultiMeasures(pred = response, test = truth)[4]
    
      ret = c(acc, auc, f1, tpRate, tnRate)
      names(ret) = c("pred.accuracy", "auc", "fScore", "TPRate", "TNRate")
      return(ret)

    })

    obj = do.call("rbind", inner.aux)
    return(obj)

  })

  df = as.data.frame(Reduce("+", aux)/length(aux))
  df$seg = colnames(temp)
  return(df)
}  

# --------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------
