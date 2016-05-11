# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getAttrsImportanceLinePlot = function(data) {

  # Converting data to numeric type
  for(i in 1:6){
    data[,i] = as.numeric(as.character(data[,i]))
  }
 
  data[which(data$dataset == "nuvem"),   "dataset"] = "cloud"
  data[which(data$dataset == "feridas"), "dataset"] = "wound"
  data[which(data$dataset == "frango"),  "dataset"] = "chicken"

  SD = c(data$sd.limiar, data$sd.kmeans, data$sd.svm)
  subset = data[, c(1:3, 7:8)]

  df = melt(subset, id.vars=c(4:5))
  df = cbind(df, SD)
  colnames(df)[3] = "Algorithm"
  
  g = ggplot(data = df, aes(x = feature, y = value, group = Algorithm, colour = Algorithm, 
    shape = Algorithm, linetype = Algorithm))
  g = g + geom_line() + geom_point() 
  g = g + geom_errorbar(aes(ymin=value-SD, ymax=value+SD), width=.1,  size=.5)
  g = g + scale_colour_brewer(palette="Dark2")
  g = g + facet_grid(dataset ~ ., scales = "free")
  g = g + theme(text = element_text(size=10), 
    axis.text.x = element_text(angle=45, vjust=1, hjust=1), # x axis text
    panel.background = element_rect(fill = "white"), #background colour
    panel.grid.major = element_line(colour = "grey90")) #background lines colour
  g = g + ylab("Mean Decrease Gini") + xlab("Meta-Features")
  
  return(g)
}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
