# IDMr - Recommending image description algorithms via Meta-learning 

There are many algorithms for image segmentation, but there is no optimal algorithm for all kind of image applications. 
*IDMr* applies meta-learning to recommend image description algorithms based on meta-knowledge. 
We performed experiments in four different meta-databases representing various real world problems, 
recommending when three different segmentation techniques are adequate or not. A set of 44 features based on color, 
frequency domain, histogram, texture, contrast and image quality were extracted from images, obtaining enough discriminative 
power for the recommending task in different segmentation scenarios. 

### Technical Requirements

R version >= 3.1.0

Required packages: 
* [mlr](https://cran.r-project.org/web/packages/mlr/index.html)
* [ggplot2] (https://cran.r-project.org/web/packages/ggplot2/index.html)
* [reshape2] (https://cran.r-project.org/web/packages/reshape2/index.html)

To install all of them in R, use the follow command:
```R
install.packages(c("mlr", "ggplot2", "reshape2" ))
```

### Run the experiments

To run the experiments, clone the repository and execute it by the command:

```
./runScript.sh &
```
It will call the bash file and start the execution creating an output log file called '*out-IDMr.log*'. You can follow 
the execution and errors checking directly the logfile.

If you want to run experiments directly through the R script, you can call the command:

````
R CMD BATCH --no-save --no-restore mainIDMr.R out-IDMr.log & 
```

Results will be saved in a directory call '*output*', one per dataset (if exist more than one).


### Contact

Rafael Gomes Mantovani (rgmantovani@gmail.com), University of São Paulo - São Carlos, Brazil.

Sylvio Barbon Junior (sbarbonjr@gmail.com), State University of Londrina - Londrina, Brazil.

Gabriel F. C. Campos (gabrielfcc@gmail.com), State University of Londrina - Londrina, Brazil.

### Reference

If you use our code/experiments in your research, please, cite our paper:

Campos, G.F.C.; Mantovani, R. G.; Barbon Jr, S. 
**A Meta-learning Approach for Recommendation of Image Segmentation Algorithms**. 
In: *SIBGRAPI 2016 - Conference on Graphics, Patterns and Images*, p 1 - 8.

