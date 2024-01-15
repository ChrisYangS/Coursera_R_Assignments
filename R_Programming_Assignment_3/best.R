## 1 Plot the 30-day mortality rates for heart attack
# outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
# outcome[, 11] <- as.numeric(outcome[, 11])
# hist(outcome[, 11])

## 2 Finding the best hospital in a state
best <- function(state, outcome) {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv",
    colClasses = "character"
  )
  ## Check that state and outcome are valid
  if (any(data$State == state)) {
    ## Return hospital name in that state with lowest 30-day death
    selectd_column_names <-
      c(
        "Hospital.Name",
        "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
        "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
        "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
      )
    df <- data[data$State == state, ][, selectd_column_names]

    ## convert selected column to number
    for (i in 2:length(df[1, ])) {
      suppressWarnings(
        df[, i] <- as.numeric(df[, i])
      )
    }

    if (outcome == "heart attack") {
      lowest_mortality <-
        min(df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
          na.rm = TRUE
        )
      # browser()
      best_hospital <- sort(df[df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack == lowest_mortality, ]
      $Hospital.Name)[1]
    } else if (outcome == "heart failure") {
      lowest_mortality <-
        min(df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,
          na.rm = TRUE
        )
      # browser()
      best_hospital <- sort(df[df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure == lowest_mortality, ]
      $Hospital.Name)[1]
    } else if (outcome == "pneumonia") {
      lowest_mortality <-
        min(df$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,
          na.rm = TRUE
        )
      # browser()
      best_hospital <- sort(df[df$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia == lowest_mortality, ]
      $Hospital.Name)[1]
    }else{
      stop("Invalid outcome")
    }
    ## rate
    return(best_hospital)
  } else{
    stop("Invalid state")
  }
}
