data1 <- read.table("c:/Users/Durga/Desktop/household_power_consumption.txt",header = TRUE,sep = ";", stringsAsFactors = FALSE)
data1$Date <- as.Date(data1$Date,"%d/%m/%Y")
data3 <- subset.data.frame(data1,data1$Date>= as.Date("2007-02-01") & data1$Date <= as.Date("2007-02-02"))
data3$Global_active_power <- as.numeric(data3$Global_active_power)
png("plot1.png",width=480,height=480)
hist(data3$Global_active_power,xlab= "Global Active Power(kilowatts)",ylab="Frequency",main ="Global Active Power",col = "red")
dev.off()

