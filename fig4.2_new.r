data = read.csv(file="/home/shuvo/Desktop/fig4_new.csv", header=TRUE, sep=",")

bin11 = data[data$ans1_reputation > 0 & data$ans1_reputation <=40, ]
bin12 = data[data$ans1_reputation > 40 & data$ans1_reputation <=300, ]
bin13 = data[data$ans1_reputation > 300 & data$ans1_reputation <=900, ]
bin14 = data[data$ans1_reputation > 900 & data$ans1_reputation <=2500, ]
bin15 = data[data$ans1_reputation > 2500 & data$ans1_reputation <=8000, ]
bin16 = data[data$ans1_reputation > 8000 & data$ans1_reputation <=100000, ]

firstAnswerersBin = list(bin11, bin12, bin13, bin14, bin15, bin16)

bin21 = data[data$ans2_reputation > 0 & data$ans2_reputation <=40, ]
bin22 = data[data$ans2_reputation > 40 & data$ans2_reputation <=300, ]
bin23 = data[data$ans2_reputation > 300 & data$ans2_reputation <=900, ]
bin24 = data[data$ans2_reputation > 900 & data$ans2_reputation <=2500, ]
bin25 = data[data$ans2_reputation > 2500 & data$ans2_reputation <=8000, ]
bin26 = data[data$ans2_reputation > 8000 & data$ans2_reputation <=100000, ]

secondAnswerersBin = list(bin21, bin22, bin23, bin24, bin25, bin26)

distribution = matrix(ncol=6, nrow=6)

i = 1
for(bin1 in firstAnswerersBin){
  j = 1  
  for(bin2 in secondAnswerersBin){
    firstAnswererQuesIds = bin1["qid",]
    secondAnswererQuesIds = bin2["qid",]
    totalNumberOfQuestions = nrow(bin1)
    merged = merge(bin1, bin2, by='qid')
    numberOfQuestionsAnsweredBySecondAnswer = nrow(merged)
    probability = numberOfQuestionsAnsweredBySecondAnswer/totalNumberOfQuestions
    distribution[i, j] = probability
    j = j+1
  }
  i = i + 1
}

distMean = mean(distribution)
distMedian = median(distribution)

for(i in 1:6){
  for(j in 1:6){
    distribution[i,j] = distribution[i,j] - distMedian
  }
}
print(distribution)

line1 = c(distribution[1,])
line2 = c(distribution[2,])
line3 = c(distribution[3,])
line4 = c(distribution[4,])
line5 = c(distribution[5,])
line6 = c(distribution[6,])

# Graph cars using a y axis that ranges from 0 to 12
plot(line4, xlab='Reputation for first answerer', ylab='Deviation from baseline probability for answering', 
     type="o", col="red", ylim=c(-0.07,0.05), lwd=3, pch=19, xaxt='n')

axis(1, 1:6, c("1-40","41-300", "301-900", "901-2500", "2501-8000", "8001-100000"))

lines(line5, type="o", pch=19, lty=1, col="blue", lwd=3)
lines(line6, type="o", pch=19, lty=1, col="green", lwd=3)

legend(5,0.05, legend=c("9001-2500", "2501-8000", "8001-100000"),
       col=c("red", "blue", "green"), lty=1, cex=0.8, lwd=3)



