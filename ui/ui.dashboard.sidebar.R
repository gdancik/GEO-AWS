#################################################################
# Dashboard sidebar
#################################################################

gse.input = div(style = "display:inline-block; width: 75%",
            selectizeInput('GSE', label = "Accession Number", 
		choices = NULL, width = 275,
              options = list(placeholder = "Please enter a GSE #",
                          maxOptions = 100)
            )
)


gse.button = div(style = "display:inline-block; width: 11%",
                actionButton("submitButton", "Go!")
)


gse.platform =  #conditionalPanel(condition = "output.sidebarDisplay=='PLATFORM'|output.sidebarDisplay=='ALL'",

                  div(style = "display:none; width: 75%", id = 'platform-div',
                        selectizeInput('platform', label = "Platform", choices = NULL, width = 275,
                                options = list(placeholder = "Please select a platform",
                                maxOptions = 10)
                        )
                  )
#)

mymenuItem <- function(...) {
  m <- menuItem(...)
  m$attribs <- list(class = 'hidden-on-start')
  m
}

cacheMenuItem <- NULL
if(DEPLOY == "docker") { 
  cacheMenuItem <- menuItem("Cache", tabName = "Cache", icon = icon("database"))
}

sidebar = dashboardSidebar(width = 350,
  includeCSS('www/ecsu.css'),
  includeScript('www/ecsu.js'),
        gse.input, gse.button, gse.platform,
        sidebarMenu(id = "tabs",
                hr(class = 'hidden-on-start'),
          mymenuItem("New Analysis", tabName = "NewAnalysis", icon = icon("refresh")),
          hr(),
          menuItem("Home", tabName = "Home", icon = icon("home"), selected = TRUE),
          mymenuItem("Differential Expression Analysis",
                tabName = "DifferentialExpressionAnalysis", icon = icon("flask")),
          mymenuItem("Survival Analysis", tabName = "SurvivalAnalysis", icon = icon("life-ring")),
          mymenuItem("View Sample Data Table", tabName = "FullDataTable", icon = icon("table")),
          mymenuItem("Code", tabName = "Code", icon = icon("code")),
          cacheMenuItem,
          menuItem("About", tabName = "About", icon = icon("info-circle"))
        )
)



