rankhospital <- function(state, outcome, num = "best") {
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
      # browser()

      ## dertermin numbe of rows
      max_row <- sum(!is.na(df$
        Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
      if (max_row >= 1) {
        min_row <- 1
      } else {
        return(NA)
      }

      if (num == "best") {
        ranking <- min_row
      } else if (num == "worst") {
        ranking <- max_row
      } else {
        ranking <- num
      }

      best_hospital <- df[order(
        df$
          Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
        df$Hospital.Name
      ), ][ranking, 1]
    } else if (outcome == "heart failure") {
      # browser()
      max_row <- sum(!is.na(df$
        Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
      if (max_row >= 1) {
        min_row <- 1
      } else {
        return(NA)
      }

      if (num == "best") {
        ranking <- min_row
      } else if (num == "worst") {
        ranking <- max_row
      } else {
        ranking <- num
      }

      best_hospital <- df[order(
        df$
          Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,
        df$Hospital.Name
      ), ][ranking, 1]
    } else if (outcome == "pneumonia") {
      # browser()
      max_row <- sum(!is.na(df$
        Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
      if (max_row >= 1) {
        min_row <- 1
      } else {
        return(NA)
      }

      if (num == "best") {
        ranking <- min_row
      } else if (num == "worst") {
        ranking <- max_row
      } else {
        ranking <- num
      }

      best_hospital <- df[order(
        df$
          Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,
        df$Hospital.Name
      ), ][ranking, 1]
    } else {
      stop("Invalid outcome")
    }


    ## rate
    return(best_hospital)
  } else {
    stop("Invalid state")
  }
}
