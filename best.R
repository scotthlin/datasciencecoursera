##
best <- function(state, outcome) {
    ## Read outcome data
    outcomecsv <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ##Check that state and outcome are valid
    statevec <- unique(outcomecsv[,"State"])
    if(!is.element(state, statevec)) {
        stop("invalid state")
    } 
    
    if(outcome == "heart attack") {
        outcol <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    } else if (outcome == "pneumonia") {
        outcol <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    } else if (outcome == "heart failure") {
        outcol <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    } else {
        stop("invalid outcome")
        best("TX", "heart attack")    
    }

    
    ##return outcome    
    statecsv <- outcomecsv[outcomecsv$State == state, c("Hospital.Name", outcol)]
    suppressWarnings(statecsv[,outcol] <- as.numeric(statecsv[,outcol]))
    statecsv <- statecsv[complete.cases(statecsv),]
    hospitalvec <- statecsv[statecsv[outcol] == min(statecsv[,outcol], na.rm=TRUE), "Hospital.Name"]
    hospitalvec <- hospitalvec[order(hospitalvec)] 
    return(hospitalvec[1])
}