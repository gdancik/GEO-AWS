# This script updates and processes platform data from 
# http://www.ncbi.nlm.nih.gov/geo/browse/?view=platforms
# and series data from http://www.ncbi.nlm.nih.gov/geo/browse/?view=series


library(rvest)
library(readr)


observeEvent(input$updateButton, {
    
    shinyjs::disable("GSE")
    shinyjs::disable("submitButton")

    updateDate <- format(Sys.Date(), "%m/%d/%y")
    total_cnt = 0
    series_total = 0
    platforms <- data.frame()
    series <- data.frame()
    

    tryCatch({
      # get platform data
      createAlert(session, "alertU", alertId = "Platform-Update-Alert", 
                  title = "Current Status", style = "shinygeo-primary",
                  content = "Updating platform (GPL) data from GEO", append = FALSE, dismiss = FALSE) 
      
      total_cnt <- read_html("https://www.ncbi.nlm.nih.gov/geo/browse/?view=platforms") %>% 
            html_node("li#total_count") %>% html_text() %>% as.integer()
  
      pages <- ceiling(total_cnt/5000)
      
      for (i in 1:pages) {
        plURL <- paste0("https://www.ncbi.nlm.nih.gov/geo/browse/?view=platforms&zsort=date&mode=csv&display=5000&page=",i)
        platforms <- rbind(platforms, read_csv(plURL))
      }
      

      # get series data
      createAlert(session, "alertU", alertId = "Series-Update-Alert", 
                  title = "Current Status", style = "shinygeo-primary",
                  content = "Updating series (GSE) data from GEO. This may take a minute, please be patient...", append = FALSE, dismiss = FALSE)
      
      series_total <- read_html("https://www.ncbi.nlm.nih.gov/geo/browse/") %>% 
        html_node("li#total_count") %>% html_text() %>% as.integer()
      
      series.pages <- ceiling(series_total/5000)
      
      for (i in 1:series.pages) {
        plURL <- paste0("https://www.ncbi.nlm.nih.gov/geo/browse/?view=series&zsort=date&mode=csv&display=5000&page=",i)
        series <- rbind(series, read_csv(plURL))
      }

    },  error = function(e) {cat("Update failed")})
    
       
    if (total_cnt != 0 && series_total !=0 && nrow(platforms) == total_cnt && nrow(series) == series_total) {
      # process platform data
      g1 = grep("oligonucleotide", platforms$Technology)
      g2 = grep("spotted DNA", platforms$Technology)
      g = c(g1,g2)
      
      platforms = platforms[g,]
      
      platforms.accession = as.character(platforms$Accession)
      platforms.description =  paste0(platforms$Title, " (", platforms$'Data Rows', " probes)")
      
      o = order(platforms.accession)
      platforms.accession = platforms.accession[o]
      platforms.description = platforms.description[o]
      
      # process series data
      g3 = grep("Expression profiling by array", series$'Series Type')
      series = series[g3,]
      series.accession = as.character(series$Accession)
      series.description = as.character(series$Title)
      
      o.series = order(series.accession)
      series.accession = series.accession[o.series]
      series.description = series.description[o.series]
      
      # backup existing platform and series data
      # GD: let's not do this for now; these can be retreived from github/docker if necessary
      #file.rename("platforms/platforms.RData", "platforms/backup-platforms.RData")
      #file.rename("series/series.RData", "series/backup-series.RData")
      
      # save platdorm and series data 
      save(platforms.accession, platforms.description, updateDate, file = "platforms/platforms.RData")
      save(series.accession, series.description, file = "series/series.RData")
  
      cat("Update successful")
      createAlert(session, "alertU", alertId = "Success-Update-Alert", 
                  title = "Update successful!", style = "info",
                  content = "", append = FALSE, dismiss = TRUE) 
      
      # change update date in shinyTitle
      shinyTitle = paste0("shinyGEO <span style ='font-size:60%;'>(updated: ", updateDate, ")<button id='updateButton' type='button' class='btn btn-default action-button shiny-bound-input' disabled>Update!</button></span>")
      output$shinyTitle = renderText(shinyTitle)
      
      #update drop down options for GSE number
      updateSelectizeInput(session, inputId='GSE', label = "Accession Number", server = TRUE,
           choices =  data.frame(label = series.accession, value = series.accession, name = series.description),
           options = list( #create = TRUE, persist = FALSE,
                      render = I("{
                          option: function(item, escape) {
                          return '<div> <strong>' + item.label + '</strong> - ' +  escape(item.name) + '</div>';
                          }
                         }"
                      ))
      )

    
    } else {
      createAlert(session, "alertU", alertId = "Error-Update-Alert", 
                  title = "Update failed, please try again later.", style = "shinygeo-danger", 
                  content = "", append = FALSE, dismiss = TRUE) 
    }
    
    shinyjs::enable("GSE")
    shinyjs::enable("submitButton")
    
  }
)
    
