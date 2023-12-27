# run_analysis.R

This script is used to perform data cleaning and analysis on the "Human Activity Recognition Using Smartphones" dataset. It follows the requirements of the "Getting and Cleaning Data" course project on Coursera.

## Prerequisites

Before running the script, make sure you have the following:

- R programming language installed
- The "dplyr" package installed (you can install it using `install.packages("dplyr")`)

## Usage

1. Download the dataset from the following link: [Dataset Link](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

2. Extract the dataset and place the `UCI HAR Dataset` folder in the same directory as the `run_analysis.R` script.

3. Open R or RStudio and set the working directory to the location of the `run_analysis.R` script.

4. Run the script using the command: `source("run_analysis.R")`

5. The script will perform the following steps:

    - Load the necessary data files.
    - Merge the training and test datasets.
    - Extract only the measurements on the mean and standard deviation for each measurement.
    - Apply descriptive activity names to the activities in the dataset.
    - Label the dataset with descriptive variable names.
    - Create a tidy dataset with the average of each variable for each activity and each subject.
    - Save the tidy dataset as `output_data.csv` in the working directory.

## Output

The script will generate a tidy dataset file named `output_data.csv` in the working directory. This file contains the average of each variable for each activity and each subject.


