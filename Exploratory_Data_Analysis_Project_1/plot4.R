#Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
png("./figure/plot4.png", width=480, height=480)

#define 2 x 2 sub plots
par(mfrow=c(2,2))
# Subplot 1
with(df,plot(DateTime,Global_active_power,type = 'l' 
             ,ylab = 'Global Active Power',xlab = '', xaxt='n'))
axis(side = 1, at = 
       c(as.numeric(df$DateTime[1]),
         as.numeric(df$DateTime[1441]),
         as.numeric(df$DateTime[2880])),labels = c("Thu","Fri","Sat"))

# Subplot 2
with(df,plot(DateTime,Voltage,type = 'l' 
             ,ylab = 'Voltage',xlab = 'datetime', xaxt='n'))
axis(side = 1, at = 
       c(as.numeric(df$DateTime[1]),
         as.numeric(df$DateTime[1441]),
         as.numeric(df$DateTime[2880])),labels = c("Thu","Fri","Sat"))

# Subplot 3
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

# Subplot 4
with(df,plot(DateTime,Global_reactive_power,type = 'l',
             xlab = 'datetime', xaxt='n'))
axis(side = 1, at = 
       c(as.numeric(df$DateTime[1]),
         as.numeric(df$DateTime[1441]),
         as.numeric(df$DateTime[2880])),labels = c("Thu","Fri","Sat"))

# Save the file
dev.off()