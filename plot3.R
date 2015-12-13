plot3 <- function(){
    library(data.table)
    library(graphics)
    library(grDevices)
    
    # First we need to extract ONLY the needed data
    data <- fread("household_power_consumption.txt", na.strings = "?")[Date == "1/2/2007" | Date == "2/2/2007",
                .(Date, Time, Global_active_power, Sub_metering_1, Sub_metering_2, Sub_metering_3)]
    
    # Create a new column with joint date and time
    data$FH <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %T")
    
    # Open the png device to create plot1.png
    png("plot3.png", width = 480, height = 480)
    
    # Create an empty plot with Sub_metering_1 because it has the largest values
    plot(data$FH,                  # X values
         data$Sub_metering_1,      # Y Values
         type = "n",               # No display
         xlab = "",                # empty X label
         ylab = "Energy sub metering") # Y label
    
    # Add lines for representing Sub_metering_1, Sub_metering_2 and Sub_metering_3
    lines(data$FH, data$Sub_metering_1)
    lines(data$FH, data$Sub_metering_2, col = "red") # This line should be red
    lines(data$FH, data$Sub_metering_3, col = "blue")# And this one is blue
    
    # Add legend
    legendVector <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    legend("topright", legend = legendVector, col = c("black", "red", "blue"), lwd = 2)
    
    # close the device so R can write the plot to "plot1.png"
    dev.off()
}