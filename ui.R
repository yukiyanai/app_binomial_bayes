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
    column(1),
    column(4,
           h4("ベイズルール"),
           p(withMathJax("$$p(\\theta \\mid y) \\propto p(y \\mid \\theta) p(\\theta)$$"))
           ),
    column(4,
           h4("ベータ-二項分布モデル"),
           p(withMathJax("$$Y \\sim \\mbox{Binomial}(n, \\theta)$$")),
           p(withMathJax("$$\\theta \\sim \\mbox{Beta}(\\alpha, \\beta)$$")),
    ),
  ),

  fluidRow(
    column(4,
           h4("パラメタの設定"),
           numericInput("theta",
                        withMathJax("$$\\theta \\in [0, 1]$$"),
                        min = 0,
                        max = 1,
                        value = 0.5,
                        step = 0.1),
           br(),
           br(),
           br(),
           actionButton("reset", "リセット")),
    column(4,
           br(),
           actionButton("update", "データを抽出してベイズ更新"),
           br(),
           br(),
           textOutput("trials"),
           textOutput("y"),
           br(),
           h4("データ"),
           textOutput("data")),
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
                        value = 1))
  ),

  fluidRow(
      column(4,
             h3("事後分布"),
             p(withMathJax("$$p(\\theta \\mid y)$$")),
             plotOutput("posterior"),
             p(withMathJax("$$\\theta \\mid y \\sim \\mbox{Beta}(y + \\alpha, n - y + \\beta)$$")),
             br()
             ),
      column(4,
             h3("尤度"),
             p(withMathJax("$$p(y \\mid \\theta) = L(\\theta \\mid y)$$")),
             plotOutput("likelihood"),
             p(withMathJax("$$y \\mid \\theta \\sim \\mbox{Binomial}(n, \\theta)$$")),
             br()
             ),
      column(4,
             h3("事前分布"),
             p(withMathJax("$$p(\\theta)$$")),
             plotOutput("prior"),
             p(withMathJax("$$\\theta \\sim \\mbox{Beta}(\\alpha, \\beta)$$")),
             br())
  )
    
))
