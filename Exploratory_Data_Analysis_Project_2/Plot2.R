# Question 2: Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == "24510")from 1999 to 2008? Use the base plotting system to
# make a plot answering this question.

library(ggplot2)
# Plot Emissions column from NEI data set, show emission by year
# First, aggregate emissions by year but filter fips == "24510"
NEI_by_year <- aggregate(Emissions ~ year, NEI[NEI$fips == "24510", ], sum)

# change the ggplot theme
theme_set(theme_light())

# Then, plot the data
g <- ggplot(NEI_by_year, aes(x = year, y = Emissions)) +
    geom_line() +
    labs(
        title = "Total PM2.5 Emissions by Year in Baltimore City, Maryland",
        x = "Year",
        y = "Total PM2.5 Emissions"
    )
# Last, save the plot to "plot2.png" file in figure folder.
ggsave("./figure/Plot2.png", plot = g, width = 8, height = 5, units = "in")
print('Png File has been created in the figure folder.')
