# DEPLOY options:
#   shinyapps - no cache or updates
#   docker - use cache and allow updates
#   shinyproxy - allow cache option (not implemented)

DEPLOY <- "docker" 
TRACE <- FALSE # set to true for debugging
ALLOW_UPDATE <- FALSE ## flag for update button display

if (!DEPLOY %in% c("shinyapps", "docker")) {
  stop("DEPLOY must be shinyapps, docker, or shinyproxy")
}

TEMPDIR <- tempdir() # tempdir() is session cache only
if (DEPLOY == "docker") {
  TEMPDIR <- "cache"
  ALLOW_UPDATE <- TRUE
}

# Functions below to be used for debugging
shinycat <-function(...) {
	if (TRACE) cat(...)
}
shinyprint <-function(...) print(...)

wait <- function(msg = "Click to continue...") {
  print(msg)
  s <- scan(what =  "character", n = 1)
}


