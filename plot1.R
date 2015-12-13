plot1 <- function(){
    library(data.table)
    library(graphics)
    library(grDevices)
    
    # First we need to extract ONLY the needed data
    dataFile <- "household_power_consumption.txt"
    date1 <- "1/2/2007"
    date2 <- "2/2/2007"
    data <- fread(dataFile, na.strings = "?")[Date == date1 | Date == date2,
                .(Global_active_power)]
    # Open the png device to create plot1.png
    png("plot1.png")
    
    # Plott the histogram
    hist(data$Global_active_power, # the values to be plotted
         main = "Global Active Power", # the plot title
         col = "red",                  # The red bins in the histogram are set this way
         xlab = "Global active power (Kilowatts)") # Label for "X" axis
    
    # close the device so R can write the plot to "plot1.png"
    dev.off()
}