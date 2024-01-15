pollutantmean <- function(directory, pollutant, id=1:332){
  ## `directory` is a character of length 1 indicating
  ## the location of the CSV file
  
  ## `pollutant` is a character vector of length 1 indicating 
  ## the name of the pollutant for which we will calculate the 
  ## mean; either `sulfate` or `nitrate`
  
  ## `id` is an integer vector indicating the monitor ID number
  ## to be used
  
  ## Return mean of the pollutant across all monitor list
  ## in the `id` vector (ignoring NA values)
  ## NOTE: Do not round the result!
  for (i in id) {
    file_name = sprintf("%03.0f", i)
    if (length(id) ==1){
      df = read.csv(paste(directory, 
                          paste(file_name, 'csv', sep = "."), sep = '/'))
    }
    else{
      if (i==id[1]){
        df = read.csv(paste(directory, 
                            paste(file_name, 'csv', sep = "."), sep = '/'))
      }
      else{
        df_tem = read.csv(paste(directory, 
                                paste(file_name, 'csv', sep = "."), sep = '/'))
        df = rbind(df_tem, df)
      }
    }
  }
  mean_val = mean(df[[pollutant]],na.rm=TRUE)
  return(mean_val)
}

complete <- function(directory, id=1:332){
  ## `directory` is a character vector of length 1 indicating
  ## the location of CSV file.
  
  ## `id` is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2 1041
  ## ...
  ## where `id` is the monitor ID number and `nobs` is the
  ## number of completed case
  library(dplyr)
  for (i in id){
    file_name = sprintf("%03.0f", i)
    df_raw = read.csv(paste(directory, 
                          paste(file_name, 'csv', sep = "."), sep = '/'))
    valid_count = nrow(filter(df_raw, !is.na(df_raw$sulfate) & 
                                !is.na(df_raw$nitrate)))
    if (i==id[1]){
      df = data.frame(id=i, nobs=valid_count)
    }
    else{
      df_tem = data.frame(id=i, nobs=valid_count)
      df = rbind(df,df_tem)
    }
  }
  return(df)
}


corr <- function(directory, threshold = 0){
  ## `directory` is a character vector of length 1 indicating
  ## the location of CSV file.
  
  ## `threshold` is a numeric vector of length 1 indicating 
  ## the number of completely observed observation (on all
  ## variables) required to complete the correlation between
  ## nitraate, sulfate; the default is 0
  
  ## Return a numeric vector of correlation
  ## NOTE: Do not round the result!

  result <-vector()
  for (i in 1:332){
    file_name = sprintf("%03.0f", i)
    df = read.csv(paste(directory, 
                       paste(file_name, 'csv', sep = "."), sep = '/'))
    good <- na.omit(df)
    ##browser()
    if (nrow(good) > threshold) {
      correlation <- cor(good$sulfate, good$nitrate)
      result <- append(result, correlation)
    }
  }
  return(result)
}