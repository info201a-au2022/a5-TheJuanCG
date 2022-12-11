library(tidyverse)
library(plotly)
library(ggplot2)
library(shiny)
library(dplyr)






emmissions_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

intro_panel <- tabPanel(
  "introduction",
  fluidPage(
    h1("CO2 Emissions"),
    br(),
    h3("Introduction:"),
    p("I am using a dataset that was compiled by Our World in Data.
      With this dataset we are able to use data to find trends in CO2 emissions.
      The ones that I have decided to focus on were CO2 growth percentage, CO2 per year, and oil CO2 per year.
      I chose CO2 growth percentage because with this we are able to see the how much a country has improved or declined on controlling their CO2 emissions.
      "),
    strong("Country with Highest CO2 Emissions"),
    tableOutput("highest_emission"),
    p("This shows the country with the highest CO2 emissions growth percentage of the most recent year that is in the dataset which is 2021.
      It shows the country name, CO2 emissions percentage growth, number of CO2 emissions in million tonnes, and population.
      I chose this to show an example of a country that has not been improving on their CO2 emissions."),
    tableOutput("yearly_co2"),
    p("This show the number of CO2 emissions produced per year (from 2000 to 2021) in million tonnes for all countries put together.
      I chose to make this because it could show the trend of CO2 produced per year and if it is improving or not."),
    tableOutput("yearly_oil"),
    p("This shows the number of oil CO2 emissions that are produced per year (from 2000 to 2021) in million tonnes for all countries.
      Because oil is one of the bigger contributions to CO2 emissions I wanted to see how it would compare to the total CO2 per year")
  )
)

visualization_panel <- tabPanel(
  "Visualization",
  h2("Oil CO2 compared to Total CO2"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "year", label = "Total CO2 Year Range", min = 1900, max = 2021, step = 1,
                  value = c(1900, 2021), sep = ""),
      
      sliderInput(inputId = "oil_year", label = "Total Oil CO2 Year Range", min = 1900, max = 2021, step = 1,
                  value = c(1900, 2021), sep = "")
    ),
    
    mainPanel(
      plotlyOutput(outputId = "line")
    )
  ),
  h3("Correlation between oil CO2 emissions and total CO2 emissions"),
  p("What the line chart reveals is that while when oil CO2 has been going up the past couple of years,
    and with it also does total CO2 emissions, it is not the only thing that has been cause CO2 emissions to go up in the years since around 1975.
    So, while cutting down our oil CO2 emissions would definitely cut down emission there are other cause that we also need to look at.")
)









ui <- navbarPage(
  theme = NULL,
  "A5",
  intro_panel,
  visualization_panel
)

