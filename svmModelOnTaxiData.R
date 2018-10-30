trainData = read.csv(file="/home/shuvo/Downloads/873groupBset2taxi/train_cleaned.csv", header=TRUE, sep=",")
trainData$X = NULL
testData = read.csv(file="/home/shuvo/Downloads/873groupBset2taxi/test_cleaned.csv", header=TRUE, sep=",")
testData$X = NULL

sampleTrainingData = trainData[sample(nrow(trainData), 50000),]

library(e1071)

svmfit = svm(sampleTrainingData$tipsType ~ ., data = sampleTrainingData, scale = FALSE, kernel = "radial")
print(svmfit)

pred = predict(svmfit,testData)
cm = as.matrix(table(testData$tipsType, pred))
cm

n = sum(cm) # number of instances
nc = nrow(cm) # number of classes
diag = diag(cm) # number of correctly classified instances per class 
rowsums = apply(cm, 1, sum) # number of instances per class
colsums = apply(cm, 2, sum) # number of predictions per class
p = rowsums / n # distribution of instances over the actual classes
q = colsums / n # distribution of instances over the predicted classes

accuracy = sum(diag) / n 
accuracy

#perclass precision, recall, accuracy

precision = diag / colsums 
recall = diag / rowsums 
f1 = 2 * precision * recall / (precision + recall) 
data.frame(precision, recall, f1) 
