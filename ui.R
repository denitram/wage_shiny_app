# load shiny package
library(shiny)

# shiny UI 
shinyUI(navbarPage("Developing Data Products - Shiny Project",
        # first tab
        tabPanel("Documentation",
                 br(),
                 h3("Plotting predictors for the Wage dataset"),
                 br(), 
                 p("We use the dataset", strong("Wage"), "from the",  
                   strong("ISLR"), "(Data for An Introduction to Statistical Learning with Applications in R) package."),
                 p("The dataset is splitted in training and test sets. We only plot the training set. "),
                 br(),
                 p("Go to the", em("Data Exploration"), "tab."),
                 # ordered list
                 tags$ol(
                         tags$li("Select a plot type"), 
                         tags$li("Select a group (color)"), 
                         tags$li("The option", em("Add smooth"), "adds linear regression lines to the", em("Scatter Plot"))
                 ),
                 br(),
                 p("This little", em("Shiny"), "application is primarily meant to demonstrate some aspects of a", em("Shiny's"),"web application.")
        ),
        
        #second tab
        tabPanel("Data Exploration", 
                 titlePanel("Wage data - exploration"),
                 column(3, wellPanel(
                 selectInput("plottype", label = h5("Plot Type"),
                              choices = c("Scatter Plot", "Box Plot", "Violin", "Step", "Density"), 
                              selected="Scatter Plot"), 
                 
                 radioButtons("selection1", label = h5("Select group"), 
                             choices = c("Job Class", "Education", "Race")), 
                 
                 conditionalPanel(
                         condition = "input.plottype == 'Scatter Plot'",
                         checkboxInput('plotoption', label="Add smooth", value = FALSE)
                        )
                 )),
                 
                column(7, plotOutput("plot1"))
        )) 
)