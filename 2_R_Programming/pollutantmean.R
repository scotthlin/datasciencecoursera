pollutantmean <- function(directory, pollutant, id = 1:332) {
        meanvect <- c()
        for (i in seq_along(id)) {
            k <- id[i]
            filename <- paste(directory,"/",sprintf("%03d",k),".csv", sep="")
            filetable <- read.csv(filename)
            meanvect <- c(meanvect, filetable[,pollutant])
        }
        return(mean(meanvect, na.rm = TRUE))
}