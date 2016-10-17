# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# Loading packages
library("mlr")
library("ggplot2")
library("reshape2")
library("BBmisc")

configureMlr(on.learner.error = "warn")
configureMlr(show.info = TRUE)

# Possible learners
predefined.learners = c("classif.randomForest", "classif.svm", "classif.kknn",
  "classif.J48", "classif.avNNet", "classif.logreg", "classif.naiveBayes")

# classif.gbm, classif.xgboost

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
