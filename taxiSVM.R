trainData = read.csv(file="/home/shuvo/Downloads/873groupBset2taxi/chicago_taxi_trips_2016_01.csv", header=TRUE, sep=",")
attach(trainData)
# summary(data$taxi_id)
# 
# summary(trip_start_timestamp)
# 
# summary(trip_end_timestamp)
# 
# summary(trip_miles)
summary(dropoff_census_tract)
#remove columns
trainData$taxi_id = NULL
trainData$pickup_latitude = NULL
trainData$pickup_longitude = NULL
trainData$pickup_census_tract = NULL
trainData$dropoff_census_tract = NULL
trainData$dropoff_latitude = NULL
trainData$dropoff_longitude = NULL

trainData = na.omit(trainData)

trainData = trainData[trainData$payment_type != "Cash", ]

trainData = trainData[trainData$trip_miles > 0,]
trainData = trainData[trainData$fare>0,]
trainData$tipsRatio = trainData$tips / trainData$trip_total
#hist( trainData$tipsRatio)
# highTipsData = trainingData[trainingData$tipsRatio>0.6,]
# plot(highTipsData$trip_total, highTipsData$tipsRatio)

library(lubridate)
# trainingData = trainingData[!(hour(as.character(trainingData$trip_start_timestamp)) == 0 && minute(as.character(trainingData$trip_start_timestamp)) == 0 && second(as.character(trainingData$trip_start_timestamp)) == 0),]
# trainingData = trainingData[!(hour(as.character(trainingData$trip_end_timestamp)) == 0 && minute(as.character(trainingData$trip_end_timestamp)) == 0 && second(as.character(trainingData$trip_end_timestamp)) == 0),]
trainData$trip_start_hour = hour(as.character(trainData$trip_start_timestamp))
trainData$trip_end_hour = hour(as.character(trainData$trip_end_timestamp))


hist(trainingData$trip_start_hour)
hist(trainingData$trip_end_hour)
hist(trainData$tipsRatio)

trainData$trip_start[trainData$trip_start_hour >= 1 & trainData$trip_start_hour < 9] = "early"
trainData$trip_start[trainData$trip_start_hour >= 9 & trainData$trip_start_hour < 18] = "mid"
trainData$trip_start[is.na(trainData$trip_start)] = "late"
trainData$trip_start = as.factor(trainData$trip_start)

trainData$trip_end[trainData$trip_end_hour >= 1 & trainData$trip_end_hour < 9] = "early"
trainData$trip_end[trainData$trip_end_hour >= 9 & trainData$trip_end_hour < 18] = "mid"
trainData$trip_end[is.na(trainData$trip_end)] = "late"
trainData$trip_end = as.factor(trainData$trip_end)

trainData$tipsType[trainData$tipsRatio <=0.15] = "low"
trainData$tipsType[trainData$tipsRatio > 0.15 & trainData$tipsRatio <= 0.30] = "mid"
trainData$tipsType[trainData$tipsRatio > 0.30] = "high"
trainData$tipsType = as.factor(trainData$tipsType)

plot(trainData$tipsType)
summary(trainData$tipsType)

#remove computed and not needed columns
trainData$trip_start_timestamp = NULL
trainData$trip_end_timestamp = NULL
trainData$trip_start_hour = NULL
trainData$trip_end_hour = NULL
trainData$tips = NULL
trainData$tipsRatio = NULL
trainData$trip_start = NULL
# plot(trainingData$trip_start_time, trainingData$tipsRatio)
# plot(trainingData$trip_end_time, trainingData$tipsRatio)
write.csv(trainData, file="/home/shuvo/Downloads/873groupBset2taxi/train_cleaned.csv")

sampleTrainingData = trainData[sample(nrow(trainData), 3000),]
write.csv(sampleTrainingData, file="/home/shuvo/Downloads/873groupBset2taxi/sampleTrainingTaxiData.csv")


