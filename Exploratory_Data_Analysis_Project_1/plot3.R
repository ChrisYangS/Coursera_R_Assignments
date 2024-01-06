#Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
png("./figure/plot3.png", width=480, height=480)
# Plot the data
with(df, plot(DateTime,Sub_metering_1,type = 'l'
              ,ylab = 'Energy sub metering',xlab = '', xaxt='n'))
with(df,lines(DateTime,Sub_metering_2, col='red'))
with(df,lines(DateTime,Sub_metering_3, col='blue'))
legend("topright",lty = 1, col=c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

axis(side = 1, at = 
       c(as.numeric(df$DateTime[1]),
         as.numeric(df$DateTime[1441]),
         as.numeric(df$DateTime[2880])),labels = c("Thu","Fri","Sat"))
# Save the file
dev.off()
