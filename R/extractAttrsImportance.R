# --------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------

extractingAttrsImportance = function(obj) {

  # all RF models
  all.rf.models = getBMRModels(bmr = obj, learner.ids="multilabel.classif.randomForest")

  aux = lapply(all.rf.models[[1]][[1]], function(model){
    temp = getLearnerModel(model, more.unwrap = TRUE)

    # TODO: abstract to get the class name automatically
    aux2 = lapply(temp, function(elem) {
      return(elem$importance)
    })
    mat = do.call("cbind", aux2)
   
    colnames(mat) = paste(c("class.limiar", "class.kmeans", "class.svm"), colnames(mat), sep=".")
    return(mat)

  })

  return(aux)
}

# --------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------
