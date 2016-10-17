# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getMultilabelLearners = function() {

  learners.list = lapply(predefined.learners, function(algo) {

    lrn = makeImputeWrapper(
      learner = makeLearner(algo, predict.type = "prob"),
      classes = list(numeric = imputeMedian(), factor = imputeMode())
    )
  
    # remove constant features
    new.lrn = makeRemoveConstantFeaturesWrapper(learner = lrn)
 
    # Applying the binary Relevance Strategy for each label
    multilabel.lrn = makeMultilabelBinaryRelevanceWrapper(learner = new.lrn)
  
    return(multilabel.lrn)
  })

  return(learners.list)

}

# TODO: Add Tuned learner?  
# See: makeTuneWrapper

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

