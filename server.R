
# This is the Peer Assessmente Project for Coursera Developing Data
# Products course.
#
# Here you see the serve logic
#

library(shiny)

# Data from Kaggle Titantic Competition http://www.kaggle.com/c/titanic-gettingStarted
trainData <- read.table('train.csv', header = TRUE, sep = ',')
trainData$Pclass <- factor(trainData$Pclass, levels = c(3,2,1), ordered = TRUE)

# Create the linear model of data
model <- glm(Survived ~ Pclass + Sex + Age, family=binomial(), data=trainData)

shinyServer(function(input, output) {
  doPrediction <- reactive({
    test <- data.frame(
      Pclass = input$Pclass,
      Sex = input$Sex,
      Age = input$Age
    )
    test$Pclass <- factor(test$Pclass)
    pred <- predict(model, test, type='response')
    pred
  })
  
  output$modelPlot <- renderPlot({
    par(mfrow=c(1,3))
    age <- table(trainData$Age)
    hist(age, main='Survive by Age', xlim=c(0,80))
    lines(c(input$Age, input$Age), c(0, 40), col='red')
    barplot(table(trainData$Sex), main='Survive by Sex')
    barplot(table(trainData$Pclass), main='Survive by Class on Ship')
  })
  
  output$errorRate <- renderText({
    trainPrediction <- predict(model, type='response')
    er <- sum((trainPrediction >= 0.6) != (trainData$Survived == 1)) / nrow(trainData)
    er <- as.integer(er * 100)
    paste('This prediction has an error rate of', er, '%, because Age have too much NA.')
  })
  
  output$predValue <- renderText({
    paste('Probability of ',  as.integer(doPrediction() * 100), '% to have survived.')
  })
  
  output$prediction <- renderText({
    pred <- doPrediction()
    pred[pred >= 0.6] <- 'YOU SURVIVED! =)'
    pred[pred < 0.6] <- 'YOU DEAD. =('
    paste(input$Name, pred)
  })
  
})
