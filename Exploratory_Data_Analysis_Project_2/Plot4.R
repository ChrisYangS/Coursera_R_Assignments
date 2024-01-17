# Question4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library(ggplot2)

# First, map SCC data set to NEI data set
NEI_merged <- merge(NEI, SCC, by = "SCC", all.x = TRUE)

# Then, filter NEI_merged data set EI.Sector contains coal
NEI_coal <- NEI_merged[grep("coal", NEI_merged$EI.Sector, ignore.case = TRUE), ]

# Then, group NEI_coal data set by year and sum Emissions column
NEI_coal <- aggregate(Emissions ~ year, NEI_coal, sum)

# change the ggplot theme
theme_set(theme_light())

# Then, plot NEI_coal by year
g <- ggplot(NEI_coal, aes(x = year, y = Emissions)) +
    geom_line() +
    labs(
        title = "Total PM2.5 Emissions from Coal Combustion-related 
        Sources by Year in the United States",
        x = "Year",
        y = "Total PM2.5 Emissions"
    )

# Last, save the plot to "plot4.png" file in figure folder.
ggsave("./figure/Plot4.png", plot = g, width = 12, height = 5, units = "in")
print("Png File has been created in the figure folder.")
