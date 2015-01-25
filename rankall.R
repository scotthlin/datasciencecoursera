rankall <- function (outcome, num = 1) {
  ## Read outcome data
  
  outcomecsv <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  resultdf <- NULL
  tails <- FALSE
    
  if(outcome == "heart attack") {
      outcol <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  } else if (outcome == "pneumonia") {
      outcol <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  } else if (outcome == "heart failure") {
      outcol <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  } else {
      stop("invalid outcome")
  }
  
  if (as.character(num) == "best") {
      num <- 1
  } else if (as.character(num) == "worst") {
      num <- 1
      tails <- TRUE
  } else if (is.na(as.numeric(num))) {
      stop("invalid n")
  }
  
  ## Return hospital name in that state with the given rank
  
  suppressWarnings(outcomecsv[,outcol] <- as.numeric(outcomecsv[,outcol]))
  outcomecsv <- outcomecsv[complete.cases(outcomecsv),]
  statecsv <- split(outcomecsv[c("Hospital.Name", outcol)], outcomecsv$State)
  
  for(i in seq_len(length(statecsv))) {
      statename = names(statecsv)[i]
      statedf <- statecsv[[i]]
      if (nrow(statedf) < num && !(tails)) {
          resultdf <- rbind(resultdf, data.frame("hospital" = "<NA>", "state" = statename))
          next
      } else { 
          statedf <- statedf[order(statedf[2], statedf[1]),]
          if (tails) {
              resultdf <- rbind(resultdf, data.frame("hospital" = tail(statedf,1)[[1]], "state" = statename))
          } else {
              resultdf <- rbind(resultdf, data.frame("hospital" = statedf[num, 1], "state" = statename))
          }   
      }
  }
  return(resultdf) 
}