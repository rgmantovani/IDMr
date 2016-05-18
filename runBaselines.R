# --------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------

baselines = function() {

  devtools::load_all()

  data.files = list.files(path = "data", pattern = ".csv$", full.names = TRUE)
 
  # Running for all the bases
  aux = lapply(data.files, function(file){
    
    filename = gsub("data/", "", gsub("*.csv", "", file))
    cat("# Running base: ", filename, "\n")
    
    dataset = getData(filename = file)
    catf("   - data read")
    
    rd.perf = mtlRandom(data = dataset)
    rd.perf = rbind(rd.perf, c(colMeans(rd.perf[,1:5]), "avg"))
    rd.perf$alg = "random"
       
    mj.perf = mtlSingleBest(data = dataset)
    mj.perf = rbind(mj.perf, c(colMeans(mj.perf[,1:5]), "avg"))
    mj.perf$alg = "singleBest"

    obj = rbind(rd.perf, mj.perf)
    obj$dataset = filename
  
    return(obj) 

  })

  df = do.call("rbind", aux)
  write.csv(df, file="output/baselines.csv")

}

# --------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------
