# download file function to download the zip file and unzip into data folder
download_file <- function(url) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    if (!file.exists("data")) {
        dir.create("data")
    }
    if (!file.exists(destfile)) {
        download.file("url", "./data/source.zip", method = "curl")
        unzip(destfile, exdir = "data")
    }
}
