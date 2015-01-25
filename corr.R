corr <- function(directory, threshold = 0) {
    source("complete.R")
    returnvector <- as.numeric(c())
    for(i in 1:332) {
        nobs <- complete(directory,i)$nobs
        if(nobs >= threshold && nobs > 0) {
            filename <- paste(directory,"/",sprintf("%03d", i),".csv", sep="")
            filetable <- read.csv(filename)
            returnvector <- c(returnvector, cor(filetable[,2], filetable[,3], use="na.or.complete"))
        }
    }
    return(returnvector)
}