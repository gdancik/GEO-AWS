cacheTrigger <- reactive({
    list(input$cachefiles,
         input$clearcache,
         input$tabs)
})
  
observeEvent( cacheTrigger(), {
    
    if (input$tabs != "Cache") {
      return()
    }
  
    gse_files <- Sys.glob('cache/*.gz')
    gpl_files <- Sys.glob('cache/*.soft')
    
    gse_num <- length(gse_files)
    gpl_num <- length(gpl_files)
    
    gse_size <- round(sum(file.size(gse_files)) / 1e6)
    gpl_size <- round(sum(file.size(gpl_files)) / 1e6)
    cache_size <- round(gse_size + gpl_size)
    
    if (gse_num + gpl_num > 0 && cache_size < 1) {
      cache_size <- '<1'
    } else {
      if (gse_num > 0 && gse_size < 1) {
        gse_size <- '<1'
      }
      if (gpl_num > 0 && gpl_size < 1) {
        gpl_size <- '<1'
      }
    }
    
    output$cache_stats <- renderUI({
    
      if (cache_size == 0) {
        shinyjs::hide('cachefiles')
        shinyjs::hide('clearcache')
        return(HTML('<h4> Your cache is currently empty </h4>'))
      }
    shinyjs::show('cachefiles')
    shinyjs::show('clearcache')
      
    HTML('<h3> Cache size: ', cache_size, 'MB</h3>',
            '<ul><li>Number of Series (GSE) files: ',
              length(gse_files), ' (', gse_size, 'MB)</li>',
            '<li>Number of Platform (GPL) files: ',
              length(gpl_files), ' (', gpl_size, 'MB)</li>',
            '</ul>') 
    })
})
  
shinyFileChoose(input, 'cachefiles', root=c(cache='cache'),
                  filetypes=c('gz', 'soft'))

observeEvent( input$cachefiles, {

    files_selected <-  parseFilePaths(c(cache='cache'), input$cachefiles)$name
    if (length(files_selected) > 0) {
        file.remove(paste0('cache/',files_selected))
        showNotification(HTML('<h4> Cache update </h4> <p>Select files were successfully removed from the cache </p>'), 
                         duration = 4, type = 'message' )
        shinyjs::runjs('document.getElementById("shiny-notification-panel").style.top = "80%";')
    }
}, ignoreInit = TRUE)
  
observeEvent( input$clearcache, {
    files_selected <- Sys.glob(c('cache/*.gz','cache/*.soft'))
    file.remove(files_selected)
    showNotification(HTML('<h4> Cache update </h4> <p>All files successfully removed from the cache </p>'), 
                     duration = 4, type = 'message')
    shinyjs::runjs('document.getElementById("shiny-notification-panel").style.top = "80%";')
    
}, ignoreInit = TRUE)
  
  
