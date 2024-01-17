# Question6: Compare emissions from motor vehicle sources in Baltimore City
# with emissions from motor vehicle sources in Los Angeles County, California
# (fips == "06037"). Which city has seen greater changes over time in motor
# vehicle emissions?

library(ggplot2)
#-------------------------Working on Baltimore City-----------------------------
# First, Filter NEI by fips == "24510"
NEI_Baltimore <- NEI[NEI$fips == "24510", ]

# Then, map NEI_Baltimore data set to SCC data set
NEI_Baltimore <- merge(NEI_Baltimore, SCC, by = "SCC", all.x = TRUE)

# Then, filter NEI_Baltimore data set EI.Sector contains vehicles
NEI_Baltimore_Vehicle <- NEI_Baltimore[grep("vehicles", NEI_Baltimore$EI.Sector,
    ignore.case = TRUE
), ]

# Then, group NEI_Baltimore data set by year and sum Emissions column
NEI_Baltimore_Vehicle <- aggregate(Emissions ~ year, NEI_Baltimore_Vehicle, sum)

#-----------------Working on Los Angeles County, California---------------------

# First, Filter NEI by fips == "06037"
NEI_LA <- NEI[NEI$fips == "06037", ]

# Then, map NEI_LA data set to SCC data set
NEI_LA <- merge(NEI_LA, SCC, by = "SCC", all.x = TRUE)

# Then, filter NEI_LA data set EI.Sector contains vehicles
NEI_LA_Vehicle <- NEI_LA[grep("vehicles", NEI_LA$EI.Sector,
    ignore.case = TRUE
), ]

# Then, group NEI_LA data set by year and sum Emissions column
NEI_LA_Vehicle <- aggregate(Emissions ~ year, NEI_LA_Vehicle, sum)



# change the ggplot theme
theme_set(theme_light())

# Plot both NEI_LA_Vehicle and NEI_Baltimore_Vehicle by year in different line colors
g <- ggplot() +
    geom_line(data = NEI_LA_Vehicle, aes(x = year, y = Emissions, color = "red")) +
    geom_line(data = NEI_Baltimore_Vehicle, aes(
        x = year, y = Emissions,
        color = "blue"
    )) +
    labs(
        title = "Total PM2.5 Emissions from Motor Vehicle Sources by
        Year in Baltimore City and Los Angeles County, California",
        x = "Year",
        y = "Total PM2.5 Emissions"
    ) +
    scale_color_manual(
        name = "City",
        values = c("red","blue"),
        labels = c("Baltimore City", "Los Angeles County, California")
    )

# Last, save the plot to "plot6.png" file in figure folder.
ggsave("./figure/Plot6.png", plot = g, width = 8, height = 5, units = "in")
print("Png File has been created in the figure folder.")
