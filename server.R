shinycat("begin source server.R\n")

library(DT) 
library(shiny)
library(GEOquery)
library(reshape2) ## needs to be loaded before GGally
library(survival)
library(shinyBS)
library(ggplot2)
library(shinyAce)
library(knitr)
library(RCurl)
library(shinyjs)
library(survMisc)
library(shinydashboard)


library(BiocManager)
options(repos = BiocManager::repositories())

source("misc/stripchart2.R")
source("misc/plot.shiny.km.R")

shinyServer(function(input, output, session){
  
  source("server/server-reactives.R", local = TRUE)
  source("server/server-clinical.R", local = TRUE)
  source("server/server-merge.R", local = TRUE)
  source("server/server-io.R", local = TRUE)
  source("server/server-report.R", local = TRUE)
  source("server/server-selection.R", local = TRUE)
  source("server/server-output.R", local = TRUE)
  source("server/server-survival.R", local = TRUE)
  source("server/formatDE.R", local = TRUE)
  source("server/platform-update.R", local = TRUE)
  source("server/server-cache.R", local = TRUE)
  
  shinyjs::runjs('document.getElementById("startup").remove();')
  
})
