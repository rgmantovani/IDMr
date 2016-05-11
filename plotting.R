# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

plotting = function() {

  devtools::load_all()

  # Line plot
  files = list.files(path="output/attrs/", pattern=".RData$")

  # Retrieving data for the line plot
  aux = lapply(files, function(file){
    print(file)
 
    load(paste0("output/attrs/", file)) #temp
    mat.mean = Reduce("+", temp)/length(temp)

    rr = array(unlist(temp), dim = c(nrow(temp[[1]]), ncol(temp[[1]]), length(temp)))
    mat.sd = apply(rr, c(1,2), sd)
    colnames(mat.sd) = c("sd.limiar", "sd.keman", "sd.svm") 

    df = cbind(mat.mean, mat.sd)
    df = data.frame(cbind(df, rownames(df)))
    rownames(df) = NULL
    df$dataset = gsub(file, pattern="_attrs.RData", replacement="")

    return(df)
  })

  final = do.call("rbind", aux)
  colnames(final) = c("limiar", "kmean", "svm", "sd.limiar", "sd.kmeans", "sd.svm", 
    "feature", "dataset")

  g = getAttrsImportanceLinePlot(data = final)
  ggsave(plot = g, file = "AttrLinePlot.eps", height = 6, width  = 11)

}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

ploting()

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
