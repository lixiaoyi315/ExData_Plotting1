#read data
mydata1<-read.table("household_power_consumption.txt",header = T,sep=";",stringsAsFactors=F)

#subset
#x:2007-02-01
x<-subset(mydata1,Date=="1/2/2007",select = Date:Sub_metering_3)
#y:2007-02-01
y<-subset(mydata1,Date=="2/2/2007",select = Date:Sub_metering_3)
#row bined
#mydataSubset=x+y
mydataSubset<-rbind(x,y)

#combine Date$Time in one columen
mydataSubset$Date<-as.Date(mydataSubset$Date,"%d/%m/%Y")
mydataSubset$Date<-as.character (mydataSubset$Date,"%d/%m/%Y")
DateTime<-paste(mydataSubset$Date,mydataSubset$Time)
mydataSubsetNew<-cbind(DateTime,mydataSubset[,-(1:2)])
class(mydataSubsetNew$DateTime)
mydataSubsetNew$DateTime<-as.character(mydataSubsetNew$DateTime)
mydataSubsetNew$DateTime<-strptime(mydataSubsetNew$DateTime,"%d/%m/%Y %H:%M:%S")
head(mydataSubsetNew$DateTime)

#plot2
opar<-par(no.readonly = T)
family="mono"
png(file="plot2.png",width = 480,height = 480)
plot(mydataSubsetNew$DateTime,mydataSubsetNew$Global_active_power,col="grey",type = "l",ylab = "Global Active Power (kilwatts)")
par(opar)
dev.off()

