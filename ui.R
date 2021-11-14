## ui.R for app_binomial_bayes
##

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("ベータ-二項分布モデルのシミュレーション"),
    
  fluidRow(
    column(1),
    column(2,
           br(),
           img(src = "yanai_lab_logo.png", height = 120),
           br(),
           br()),
    column(4,
           h4("ベータ-二項分布モデル"),
           helpText(withMathJax("$$Y \\sim \\mbox{Binomial}(\\theta)$$")),
           helpText(withMathJax("$$\\theta \\sim \\mbox{Beta}(\\alpha, \\beta)$$"))),
    column(5)
  ),

  fluidRow(
    column(4,
           h4("パラメタの設定"),
           numericInput("theta",
                        withMathJax("$$\\theta \\in [0, 1]$$"),
                        min = 0,
                        max = 1,
                        value = 0.5),
           br(),
           br(),
           br(),
           actionButton("reset", "リセット")),
    column(4,
           h4("事前分布の設定"),
           numericInput("alpha",
                        withMathJax("$$\\alpha \\in [0.01, 100]$$"),
                        min = 0.01,
                        max = 100,
                        value = 1),
           numericInput("beta",
                        withMathJax("$$\\beta \\in [0.01, 100]$$"),
                        min = 0.01,
                        max = 100,
                        value = 1)),
    column(4,
           br(),
           actionButton("update", "データを抽出してベイズ更新"),
           br(),
           br(),
           h4("データ"),
           textOutput("data"))
  ),
  
  fluidRow(
    column(4,
           h3("事前分布"),
           plotOutput("prior")),
    column(4,
           h3("尤度"),
           plotOutput("likelihood")),
    column(4,
           h3("事後分布"),
           plotOutput("posterior"))
    )
))
