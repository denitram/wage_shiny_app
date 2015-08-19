library(shiny)
library(ISLR); library(ggplot2); library(caret);

data(Wage); 
Wage <- subset(Wage,select=-c(logwage))

# Get training/test sets  
inTrain <- createDataPartition(y=Wage$wage, p=0.7, list=FALSE)
training <- Wage[inTrain,]; testing <- Wage[-inTrain,]

# server.R
shinyServer(function(input, output, session) {
        observe({
                if(input$plottype != "point") {
                        updateCheckboxInput(session, "plotoption", value = FALSE)        
                }
        })
        
        output$text1 <- renderText({ 
                paste("You have selected: ", input$selection1)
        })
        
        # Plot age versus wage colour by education, jobclass of race
        output$plot1 <- renderPlot({
                color <- switch(input$selection1, 
                        "Education" = training$education,
                        "Job Class" = training$jobclass,
                        "Race" = training$race)
                
                plottype <- switch(input$plottype,
                                "Scatter Plot" = "point",
                                "Box Plot" = "boxplot",
                                "Violin" = "violin",
                                "Step" = "step",
                                "Density" = "density")
                
                legenda <- switch(input$selection1,
                                  "Education" = " Education",
                                  "Job Class" = "Job Class",
                                  "Race" = "Race")

                if(plottype == "density" ){
                        p <- qplot(wage, 
                                colour = color, 
                                geom = c(plottype),
                                data=training)
                } else {
                        p <- qplot(x = age, 
                                   y = wage, 
                                   colour = color, 
                                   geom = c(plottype),
                                   data=training) 
                }
                        
                p <- p + guides(colour = guide_legend(legenda), 
                           size = guide_legend(legenda),
                           shape = guide_legend(legenda))
                
                if(input$plotoption == TRUE && plottype != "density") {
                      p  + geom_smooth(method='lm', formula = y~x)
                } else {
                        p
                }
        })
})
