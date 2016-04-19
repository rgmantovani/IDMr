#--------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------

extractingAttrsImportance = function(obj) {

	# todos os modelos de RF
	all.rf.models = getBMRModels(bmr = obj, learner.ids="multilabel.classif.randomForest")

	# iterando na lista de modelos
	aux = lapply(all.rf.models[[1]][[1]], function(model){

    temp = getLearnerModel(model, more.unwrap = TRUE)

    # TODO: abstrair para pegar o nome da classe automaticamente
    aux2 = lapply(temp, function(elem) {
      return(elem$importance)
    })
    mat = do.call("cbind", aux2)
   
    colnames(mat) = paste(c("class.limiar", "class.kmeans", "class.svm"), colnames(mat), sep=".")
    return(mat)

  })

  return(aux)
}

#--------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------