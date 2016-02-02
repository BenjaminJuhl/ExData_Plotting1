
# Original data available from:
# https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip

# read the data from the provided file
# skip= 66637 and nrows= 2880 will restrict the read data to be from the time
# periode 2007-02-01 to 2007-02-02 to save time
data <- read.table("household_power_consumption.txt",na.strings = "?",
                   sep=";",stringsAsFactors=FALSE,
                   skip=66637,nrows=2880)
# manually setting names as they got lost when skipping lines
names(data) <- c("date","time","global.active.power","global.reactive,power",
                 "voltage","global.intensity","sub.metering.1","sub.metering.2",
                 "sub.metering.3")


time.long <- paste(data$date,data$time)
time.long <- strptime(time.long,format="%d/%m/%Y %H:%M:%S")

# needed to get the english weekday names in the plot, might be different
# on other systems
Sys.setlocale("LC_TIME", "English")

png("plot3.png",width=480,height=480,units="px") # set the graphic device

#ä create the plot
plot(time.long,data$sub.metering.1,type="n",xlab="",ylab="Energy sub metering")
lines(time.long,data$sub.metering.1)
lines(time.long,data$sub.metering.2,col="red")
lines(time.long,data$sub.metering.3,col="blue")
legend("topright",lty=c(1,1,1),lwd=c(1,1,1),col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off() # finish saving to file