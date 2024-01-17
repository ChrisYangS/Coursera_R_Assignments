# PART ONE: download data from 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip' to ./data folder and unzip it into the same folder

# check if the download folder exists, if not, create it
if (!file.exists("./data")) {
    dir.create("./data")
    print("Creating ./data folder")
}
# then check if the zip file exists, if not, download it
if (!file.exists("./data/NEI_data.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
                  destfile = "./data/NEI_data.zip")
    print("Downloaded NEI_data.zip")
    unzip("./data/NEI_data.zip", exdir = "./data")
    print("Unzipped NEI_data.zip")
}

# STEP TWO: Read unziped data into R
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
