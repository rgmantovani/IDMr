# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getMultilabelLearners = function() {

  learners.list = lapply(predefined.learners, function(algo) {

    lrn = makeLearner(algo, predict.type = "prob")

    # Applying the binary Relevance Strategy for each label
    multilabel.lrn = makeMultilabelBinaryRelevanceWrapper(learner = lrn)
  
    return(multilabel.lrn)
  })

  return(learners.list)

}
  
 


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


