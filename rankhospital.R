rankhospital <- function (state, outcome, num) {
    ## Read outcome data
    
    outcomecsv <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    
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
    
    if (!(as.character(num) == "best" || as.character(num) == "worst" || !is.na(as.numeric(num)))) {
      stop("invalid num")
    }
  
    ## Return hospital name in that state with the given rank
    
    statecsv <- outcomecsv[outcomecsv$State == state, c("Hospital.Name", outcol)]
    suppressWarnings(statecsv[,outcol] <- as.numeric(statecsv[,outcol]))
    statecsv <- statecsv[complete.cases(statecsv),]
    statecsv <- statecsv[order(statecsv$Hospital.Name),]
    statecsv <- statecsv[order(transform(statecsv, hosrank = rank(statecsv[outcol],ties.method="first"))["hosrank"]),]
    
    ## 30-day death rate
    
    if(!is.na(as.numeric(num))){
        return(statecsv$Hospital.Name[num])
    } else if (as.character(num) == "best") {
        return(statecsv$Hospital.Name[1])
    } else if (as.character(num) == "worst") {
        return (tail(statecsv$Hospital.Name, 1))
    }
    
}