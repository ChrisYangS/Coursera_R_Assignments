# Question3: Of the four types of sources indicated by the type (point, nonpoint,
# onroad, nonroad) variable, which of these four sources have seen decreases in
# emissions from 1999–2008 for Baltimore City? Which have seen increases in
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot
# answer this question.

library(ggplot2)
# Plot Emissions column from NEI data set, show emission by year
# First, filter NEI dataset which filter fips == "24510"
NEI_Baltimore <- NEI[NEI$fips == "24510", ]
# Then map SCC data set to NEI_Baltimore data set
NEI_Baltimore <- merge(NEI_Baltimore, SCC, by = "SCC", all.x = TRUE)
# Then, group by year and Data.Category, and sum Emissions column
NEI_Baltimore <- aggregate(Emissions ~ year + Data.Category, NEI_Baltimore, sum)

# change the ggplot theme
theme_set(theme_light())

# Then, plot the data and show each Data.Category column in different line color
g <- ggplot(NEI_Baltimore, aes(x = year, y = Emissions)) +
  geom_line(aes(color = Data.Category)) +
  scale_color_discrete(name = "Type") +
  labs(
    title = "Total PM2.5 Emissions by Type in Baltimore City, Maryland",
    x = "Year",
    y = "Total PM2.5 Emissions"
  )

# Last, save the plot to "plot3.png" file in figure folder.
ggsave("./figure/Plot3.png", plot = g, width = 8, height = 5, units = "in")
print("Png File has been created in the figure folder.")
