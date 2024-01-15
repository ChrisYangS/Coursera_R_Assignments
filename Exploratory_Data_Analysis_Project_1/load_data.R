

##STEP ONE: Loading the data

url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
folder_path<-"./data/"
dest_file_name<-"household_power_consumption.zip"
data_file_name<-"household_power_consumption.txt"

# Check if the dplyr package is installed, and install it if necessary
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
  print("install dplyr package.")
}

# Load the dplyr package
library(dplyr)
print("load dplyr into the model.")

# Check if the folder exists
if (!file.exists(folder_path)) {
  # If it doesn't exist, create the folder
  dir.create(folder_path, recursive = TRUE)
  print("Folder created successfully.")
} else {
  print("Folder already exists.")
}


download_destination <- paste(folder_path,dest_file_name,sep="")
data_destination <- paste(folder_path,data_file_name,sep="")
# Check if the zip file exists
if (!file.exists(download_destination)) {
  # Download the file using download.file()
  download.file(url, destfile = download_destination, method = "auto")
  print("File downloaded from the inernet.")
  # Unzip the file
  unzip(download_destination, exdir = folder_path)
  print("downloaded data has been unziped.")
} else {
  print("download file already exists.")
}

df <- read.delim2(data_destination,header = TRUE, sep=";")
print("Downloaded data has been loaded into a dataframe.")
print(paste("The dataframe has",dim(df)[1],"rows and",dim(df)[2],"columns."))

#convert the Date column from String to Date:
df$Date <- strptime(df$Date, format = "%d/%m/%Y")
df$DateTime <- strptime(paste(df$Date,df$Time),
                        format = "%Y-%m-%d %H:%M:%S")
# Change Global_active_power, Global_reactive_power, Voltage, 
# Global_intensity sub_metering_1, sub_metering_2 and sub_metering_3 column
# to numeric data type.
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Voltage <- as.numeric(df$Voltage)
df$Global_intensity <- as.numeric(df$Global_intensity)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)


#subset data which date is between 2007-02-01 and 2007-02-02.
df<- df %>%filter(Date >="2007-02-01" & Date <= "2007-02-02")

