testData = read.csv(file="/home/shuvo/Downloads/873groupBset2taxi/chicago_taxi_trips_2016_07.csv", header=TRUE, sep=",")
attach(testData)
# summary(data$taxi_id)
# 
# summary(trip_start_timestamp)
# 
# summary(trip_end_timestamp)
# 
# summary(trip_miles)
summary(dropoff_census_tract)
#remove columns
testData$taxi_id = NULL
testData$pickup_latitude = NULL
testData$pickup_longitude = NULL
testData$pickup_census_tract = NULL
testData$dropoff_census_tract = NULL
testData$dropoff_latitude = NULL
testData$dropoff_longitude = NULL


testData = na.omit(testData)


testData = testData[testData$payment_type != "Cash", ]

testData = testData[testData$trip_miles > 0,]
testData = testData[testData$fare>0,]
testData$tipsRatio = testData$tips / testData$trip_total

# highTipsData = trainingData[trainingData$tipsRatio>0.6,]
# plot(highTipsData$trip_total, highTipsData$tipsRatio)

library(lubridate)
# trainingData = trainingData[!(hour(as.character(trainingData$trip_start_timestamp)) == 0 && minute(as.character(trainingData$trip_start_timestamp)) == 0 && second(as.character(trainingData$trip_start_timestamp)) == 0),]
# trainingData = trainingData[!(hour(as.character(trainingData$trip_end_timestamp)) == 0 && minute(as.character(trainingData$trip_end_timestamp)) == 0 && second(as.character(trainingData$trip_end_timestamp)) == 0),]
testData$trip_start_hour = hour(as.character(testData$trip_start_timestamp))
testData$trip_end_hour = hour(as.character(testData$trip_end_timestamp))


# hist(trainingData$trip_start_hour)
# hist(trainingData$trip_end_hour)
hist(testData$tipsRatio)

testData$trip_start[testData$trip_start_hour >= 1 & testData$trip_start_hour < 9] = "early"
testData$trip_start[testData$trip_start_hour >= 9 & testData$trip_start_hour < 18] = "mid"
testData$trip_start[is.na(testData$trip_start)] = "late"
testData$trip_start = as.factor(testData$trip_start)

testData$trip_end[testData$trip_end_hour >= 1 & testData$trip_end_hour < 9] = "early"
testData$trip_end[testData$trip_end_hour >= 9 & testData$trip_end_hour < 18] = "mid"
testData$trip_end[is.na(testData$trip_end)] = "late"
testData$trip_end = as.factor(testData$trip_end)

testData$tipsType[testData$tipsRatio <=0.15] = "low"
testData$tipsType[testData$tipsRatio > 0.15 & testData$tipsRatio <= 0.30] = "mid"
testData$tipsType[testData$tipsRatio > 0.30] = "high"
testData$tipsType = as.factor(testData$tipsType)

plot(testData$tipsType)
summary(testData$tipsType)

#remove computed and not needed columns
testData$trip_start_timestamp = NULL
testData$trip_end_timestamp = NULL
testData$trip_start_hour = NULL
testData$trip_end_hour = NULL
testData$tips = NULL
testData$tipsRatio = NULL
trainData$trip_start = NULL
# plot(trainingData$trip_start_time, trainingData$tipsRatio)
# plot(trainingData$trip_end_time, trainingData$tipsRatio)
write.csv(testData, file="/home/shuvo/Downloads/873groupBset2taxi/test_cleaned.csv")