# Question5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(ggplot2)

# First, Filter NEI by fips == "24510"
NEI_Baltimore <- NEI[NEI$fips == "24510", ]

# Then, mapp NEI_Baltimore data set to SCC data set
NEI_Baltimore <- merge(NEI_Baltimore, SCC, by = "SCC", all.x = TRUE)

# Then, filter NEI_merged data set EI.Sector contains vehicles
NEI_vehicle <- NEI_merged[grep("vehicles", NEI_merged$EI.Sector, ignore.case = TRUE), ]

# Then, group NEI_Baltimore data set by year and sum Emissions column
NEI_vehicle <- aggregate(Emissions ~ year, NEI_vehicle, sum)

# change the ggplot theme
theme_set(theme_light())

# Then, plot NEI_vehicle by year
g <- ggplot(NEI_vehicle, aes(x = year, y = Emissions)) +
    geom_line() +
    labs(
        title = "Total PM2.5 Emissions from Motor Vehicle Sources by Year in Baltimore City",
        x = "Year",
        y = "Total PM2.5 Emissions"
    )

# Last, save the plot to "plot5.png" file in figure folder.
ggsave("./figure/Plot5.png", plot = g, width = 8, height = 5, units = "in")
print("Png File has been created in the figure folder.")
