plot2 <- function(){
    library(data.table)
    library(graphics)
    library(grDevices)
    
    # First we need to extract ONLY the needed data
    data <- fread("household_power_consumption.txt", na.strings = "?")[Date == "1/2/2007" | Date == "2/2/2007",
                                                                       .(Date, Time, Global_active_power)]
    
    # Create a new column with joint date and time
    data$FH <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %T")
    
    # Open the png device to create plot1.png
    png("plot2.png", width = 480, height = 480)
    
    # Create an empty plot
    plot(data$FH,                  # X values
         data$Global_active_power, # Y Values
         type = "n",               # No display
         xlab = "",                # empty X label
         ylab = "Global active power (Kilowatts)") # Y label
    
    # Add lines for representing active power
    lines(data$FH, data$Global_active_power)
    
    # close the device so R can write the plot to "plot1.png"
    dev.off()
}
