
# This is the Peer Assessmente Project for Coursera Developing Data
# Products course.
#
# Here you see user-interface definition
#


library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Titanic Survival Test"),
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(
    p("The sinking of the RMS Titanic is one of the most infamous 
      shipwrecks in history.  On April 15, 1912, during her maiden 
      voyage, the Titanic sank after colliding with an iceberg, 
      killing 1502 out of 2224 passengers and crew. This sensational 
      tragedy shocked the international community and led to better 
      safety regulations for ships."),
    h3("Check that you have survived!"),
    p("Enter your data below:"),
    
    textInput("Name", "Enter your name", "Guest"),
    radioButtons("Sex", "Select your gender:",
                 c("Male" = "male",
                   "Female" = "female")),
    radioButtons("Pclass", "Select your class on the ship:",
                 c("First Class" = 1,
                   "Second Class" = 2,
                   "Third Class" = 3)),
    # In the training data. Min = 0.42, Median = 28, Max = 80
    sliderInput("Age",
                "Enter your age:",
                min = 1,
                max = 80,
                value = 28)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    h2(textOutput('prediction')),
    p(textOutput('errorRate')),
    p(textOutput('predValue')),
    plotOutput("modelPlot")
  )
))
