plot4 <- function(){
    library(data.table)
    library(graphics)
    library(grDevices)
    
    # Save my locale configuration
    mylocale <- Sys.getlocale("LC_TIME")
    # Set language to english
    Sys.setlocale("LC_TIME", "en_US.UTF-8")
    
    # We need to extract ONLY the needed data
    dataFile <- "household_power_consumption.txt"
    date1 <- "1/2/2007"
    date2 <- "2/2/2007"
    datica <- fread(dataFile, na.strings = "?")[Date == date1 | Date == date2]
    
    # Create a new column with joint date and time
    datica$FH <- as.POSIXct(paste(datica$Date, datica$Time), format = "%d/%m/%Y %T")
    
    # Open the png device to create plot1.png
    png("plot4.png", width = 480, height = 480)
    
    # Set plot grid
    par(mfrow = c(2,2))
    
    # First plot
    plot(datica$FH, datica$Global_active_power, xlab = "",
         ylab = "Global Active Power", main = "", type = "n")
    lines(datica$FH, datica$Global_active_power)
    
    # Second plot
    plot(datica$FH, datica$Voltage,
         xlab = "datetime", ylab = "Voltage", main = "", type = "n")
    lines(datica$FH, datica$Voltage)
    
    # Third plot
    plot(datica$FH,                  # X values
         datica$Sub_metering_1,      # Y Values
         type = "n",               # No display
         xlab = "",                # empty X label
         ylab = "Energy sub metering") # Y label
    
    # Add lines for representing Sub_metering_1, Sub_metering_2 and Sub_metering_3
    lines(datica$FH, datica$Sub_metering_1)
    lines(datica$FH, datica$Sub_metering_2, col = "red") # This line should be red
    lines(datica$FH, datica$Sub_metering_3, col = "blue")# And this one is blue
    
    # Add legend
    legendVector <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    legend("topright", legend = legendVector, col = c("black", "red", "blue"), lwd = 2)
    
    # Fourth plot
    plot(datica$FH, datica$Global_reactive_power,
         xlab = "datetime", ylab = "Global_reactive_power", main = "", type = "n")
    lines(datica$FH, datica$Global_reactive_power)
    
    # close the device so R can write the plot to "plot1.png"
    dev.off()
    
    # set the original language locale
    Sys.setlocale("LC_TIME", mylocale)
}