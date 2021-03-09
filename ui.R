
library(shinyAce)
library(RCurl)
library(shinyBS)
library(shinydashboard)
library(shinyFiles)

source("misc/html.R")
source("misc/bsModal.R")
source("ui/ui.dashboard.header.R")
source("ui/ui.dashboard.sidebar.R")
source("ui/ui.dashboard.body.R")

shinyUI(
  dashboardPage(title = "shinyGEO",
    header,
    sidebar,
    body
  )
)


