# server.R for app_binomial_bayes

library(shiny)
library(tidyverse)

if (.Platform$OS.type == "windows") { 
    if (require(fontregisterer)) {
        my_font <- "Yu Gothic"
    } else {
        my_font <- "Japan1"
    }
} else if (capabilities("aqua")) {
    my_font <- "HiraginoSans-W3"
} else {
    my_font <- "IPAexGothic"
}

theme_set(theme_gray(base_size = 12,
                     base_family = my_font))

theta <- seq(0, 1, length.out = 1000)

# Likelihood function
f_L <- function(theta, n, x) {
  choose(n, x) * theta^x * (1 - theta) ^(n - x)
}

shinyServer(function(input, output) {
  
  y <- reactiveVal()
  
  observeEvent(input$reset, {
    y(NULL)
  })
  
  observeEvent(input$update, {
    new_y <- rbinom(1, size = 1, prob = input$theta)
    y(c(y(), new_y))
  })
  
  output$data <- renderText({
    as.character(y())
  })
  
  output$trials <- renderText({
    paste("n = ",
          as.character(length(y())))
  })
  
  output$y <- renderText({
    paste("y = ", 
          y = as.character(sum(y())))
  })

  output$prior <- renderPlot({
    y <- dbeta(theta, shape1 = input$alpha, shape2 = input$beta)
    p0 <- ggplot(data.frame(x = theta, y = y), 
                 aes(x = x, y = y)) +
        geom_hline(yintercept = 0, color = "gray") +
        geom_line(color = "black") +
        labs(x = expression(theta),
             y = "確率密度")
    p0
  })

  output$likelihood <- renderPlot({
    L <- theta %>% 
      map(.f = f_L,
          n = length(y()),
          x = sum(y())) %>% 
      unlist()
    df <- data.frame(x = theta, y = L)
    pL <- ggplot(df, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, color = "gray") +
      geom_line(color = "royalblue") +
      labs(x = expression(theta),
           y = "尤度")
    pL
    })
  
  output$posterior <- renderPlot({
    y <- dbeta(theta, 
               shape1 = input$alpha + sum(y()), 
               shape2 = input$beta + length(y()) - sum(y()))
    p1 <- ggplot(data.frame(x = theta, y = y), 
                 aes(x = x, y = y)) +
      geom_hline(yintercept = 0, color = "gray") +
      geom_line(color = "tomato") +
      labs(x = expression(theta),
           y = "確率密度")
    p1
  })
})
