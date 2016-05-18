# --------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------

accMultiMeasures = function(pred, test) {

  levels(pred) = levels(test)
  confusion.matrix = table(pred, test)
  final.matrix = vector("numeric", 4)
  names(final.matrix) = c("error", "precision", "recall", "fscore")
  
  mat.res = matrix(0, nrow(confusion.matrix), 3)
  rownames(mat.res) = colnames(confusion.matrix)
  colnames(mat.res) = c("precision", "recall", "fscore")
  
  for (i in 1:nrow(mat.res)) {
  
    if (sum(confusion.matrix[,i])==0) {
      mat.res[i,"precision"] = 0
    } else {
      mat.res[i,"precision"] = confusion.matrix[i,i]/sum(confusion.matrix[,i])
    }

    if (sum(confusion.matrix[i,])==0) {
      mat.res[i,"recall"] = 0
    } else {
      mat.res[i,"recall"] = confusion.matrix[i,i]/sum(confusion.matrix[i,]) 
    }
    
    if ((mat.res[i,"precision"]==0) && (mat.res[i,"recall"]==0)) {
      mat.res[i, "fscore"] = 0
    } else {
      mat.res[i,"fscore"] = (2*mat.res[i,"precision"]*mat.res[i,"recall"])/(mat.res[i,"precision"] 
        + mat.res[i,"recall"])
    }   
  }
  
  idx = matrix(seq(1:nrow(confusion.matrix)),nrow(confusion.matrix),2)
  final.matrix["error"] = 1 - (sum(confusion.matrix[idx])/sum(confusion.matrix))
  final.matrix[c("precision", "recall", "fscore")] = apply(mat.res, 2, mean)
  
  return (final.matrix)
}

# --------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------
