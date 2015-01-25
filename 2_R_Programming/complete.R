complete <- function(directory, id = 1:332) {
    returnframe <- data.frame(id, nobs=0)
    for(i in seq_along(id)) {
          k <- id[i]
          filename <- paste(directory,"/",sprintf("%03d", k),".csv", sep="")
          filetable <- read.csv(filename)
          returnframe[i, "nobs"] <- sum(complete.cases(filetable))
    }
    return(returnframe)
}