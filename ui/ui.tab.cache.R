tab.cache <- tabItem('Cache', 
               bsAlert('cacheAlert'),
               uiOutput('cache_stats'),
               hr(style = 'height:1px; background-color: rgb(0, 38, 73)'),
                 shinyFilesButton('cachefiles', label='Select files for removal', 
                                  title='Please select files to delete', 
                                  multiple=TRUE, buttonType = 'primary',
                                  filetype = list(geo = c("gz", "soft"))
                                  ),
               
               HTML("<button id='clearcache' type='button' class='btn btn-danger action-button'>Clear Cache</button>")
               
                )