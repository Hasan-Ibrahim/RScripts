data = read.csv(file="/home/shuvo/Desktop/fig4.csv", header=TRUE, sep=",")

bin11 = data[data$reputation_a_1 > 0 & data$reputation_a_1 <=40, ]
bin12 = data[data$reputation_a_1 > 40 & data$reputation_a_1 <=300, ]
bin13 = data[data$reputation_a_1 > 300 & data$reputation_a_1 <=900, ]
bin14 = data[data$reputation_a_1 > 900 & data$reputation_a_1 <=2500, ]
bin15 = data[data$reputation_a_1 > 2500 & data$reputation_a_1 <=8000, ]
bin16 = data[data$reputation_a_1 > 8000 & data$reputation_a_1 <=100000, ]

firstAnswerersBin = list(bin11, bin12, bin13, bin14, bin15, bin16)

bin21 = data[data$reputation_a_2 > 0 & data$reputation_a_2 <=40, ]
bin22 = data[data$reputation_a_2 > 40 & data$reputation_a_2 <=300, ]
bin23 = data[data$reputation_a_2 > 300 & data$reputation_a_2 <=900, ]
bin24 = data[data$reputation_a_2 > 900 & data$reputation_a_2 <=2500, ]
bin25 = data[data$reputation_a_2 > 2500 & data$reputation_a_2 <=8000, ]
bin26 = data[data$reputation_a_2 > 8000 & data$reputation_a_2 <=100000, ]

secondAnswerersBin = list(bin21, bin22, bin23, bin24, bin25, bin26)

distribution = matrix(ncol=6, nrow=6)

i = 1
for(bin1 in firstAnswerersBin){
  j = 1  
  for(bin2 in secondAnswerersBin){
      firstAnswererQuesIds = bin1["id_q",]
      secondAnswererQuesIds = bin2["id_q",]
      totalNumberOfQuestions = nrow(bin1)
      merged = merge(bin1, bin2, by='id_q')
      numberOfQuestionsAnsweredBySecondAnswer = nrow(merged)
      print(merged)
      probability = numberOfQuestionsAnsweredBySecondAnswer/totalNumberOfQuestions
      print(probability)
      distribution[i, j] = probability
      j = j+1
  }
  i = i + 1
}
print(distribution)
distMean = mean(distribution)
distMedian = median(distribution)

for(i in 1:6){
  for(j in 1:6){
    distribution[i,j] = distribution[i,j] - distMean
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
plot(line1, xlab='Reputation for first answerer', ylab='Deviation from baseline probability for answering', 
     type="o", col="red", ylim=c(-0.07,0.05), lwd=3, pch=19, xaxt='n')

axis(1, 1:6, c("1-40","41-300", "301-900", "901-2500", "2501-8000", "8001-100000"))

lines(line2, type="o", pch=19, lty=1, col="blue", lwd=3)
lines(line3, type="o", pch=19, lty=1, col="green", lwd=3)

legend(5,0.05, legend=c("1-40", "41-300", "301-900"),
       col=c("red", "blue", "green"), lty=1, cex=0.8, lwd=3)
