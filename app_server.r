library(tidyverse)
library(plotly)
library(ggplot2)
library(shiny)
library(dplyr)

emissions_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")


country_highest <- emissions_data %>% filter(year == max(year)) %>%
  filter(co2_growth_prct == max(co2_growth_prct, na.rm = TRUE)) %>%
  select(country, co2_growth_prct, co2, population)


co2_per_year <- emissions_data %>% select(co2, year) %>% filter(year > 2000) %>%
  group_by(year) %>% mutate(total_co2 = sum(co2, na.rm = TRUE)) %>%
  select(year, total_co2) %>% distinct()

oil_co2_year <- emissions_data %>% filter(year > 2000) %>%
  group_by(year) %>% mutate(total_oil_co2 = sum(oil_co2, na.rm = TRUE)) %>%
  select(year, total_oil_co2) %>% distinct()


## For scatter plot
co2_per_year_scatter <- emissions_data %>% select(co2, year) %>% filter(year > 1900) %>%
  group_by(year) %>% mutate(total_co2 = sum(co2, na.rm = TRUE)) %>%
  select(year, total_co2) %>% distinct()

oil_co2_year_scatter <- emissions_data %>% filter(year > 1900) %>%
  group_by(year) %>% mutate(total_oil_co2 = sum(oil_co2, na.rm = TRUE)) %>%
  select(year, total_oil_co2) %>% distinct()

oil_co2_year_scatter <- rename(oil_co2_year_scatter, oil_year = year)



server <- function(input, output) {
  output$highest_emission <- renderTable(country_highest)
  
  output$yearly_co2 <- renderTable(co2_per_year)
  
  output$yearly_oil <- renderTable(oil_co2_year)
  
  
  
  output$line <- renderPlotly({
    
    colors <- c("Oil" = "blue", "Total" = "red")
    
    chosen1 <- co2_per_year_scatter %>% filter(year >= input$year[1] & year <= input$year[2])
    chosen2 <- oil_co2_year_scatter %>% filter(oil_year >= input$oil_year[1] & oil_year <= input$oil_year[2])
    p <- ggplot() + 
      geom_line(data = chosen1, aes(x = year, y = total_co2, color = "Total")) +
      geom_line(data = chosen2, aes(x = oil_year, y = total_oil_co2, color = "Oil")) +
      labs(x = "Year",
           y = "CO2 Emission in Million Tonnes",
           color = "Legend")
    
    p_plotly <- ggplotly(p)
    return(p_plotly)
  })
}

    
    
    
    
