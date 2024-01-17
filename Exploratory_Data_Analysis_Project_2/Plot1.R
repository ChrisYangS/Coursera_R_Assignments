# Question 1: Have total emissions from PM2.5 decreased in the United States
# from 1999 to 2008? Using the base plotting system, make a plot showing the
# total PM2.5 emission from all sources for each of the years 1999, 2002, 2005,
# and 2008.

png(filename="./figure/Plot1.png")

# First, aggregate emissions by year
NEI_by_year <- aggregate(Emissions ~ year, NEI, sum)

# Then, plot the data
plot(NEI_by_year$year, NEI_by_year$Emissions,
    type = "l", xlab = "Year",
    ylab = "Total PM2.5 Emissions",
    main = "Total PM2.5 Emissions from All Sources by Year"
)


print("Png File has been created in the figure folder.")
dev.off()