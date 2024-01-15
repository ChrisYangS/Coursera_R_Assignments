#Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
png("./figure/plot1.png", width=480, height=480)
# Plot the data
hist(df$Global_active_power, col='red',xlab = 'Global Active Power(kilowatts)'
     , ylab = 'Frequency', main = 'Global Active Power')
# Save the file
dev.off()