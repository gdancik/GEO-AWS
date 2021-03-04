
TEMPDIR <- tempdir() # #either 'cache' for 'permanent' cache or tempdir() for session only cache
TRACE <- FALSE # set to true for debugging
ALLOW_UPDATE <- FALSE ## flag for update button display

# Functions below to be used for debugging
shinycat <-function(...) {
	if (TRACE) cat(...)
}
shinyprint <-function(...) print(...)

wait <- function(msg = "Click to continue...") {
  print(msg)
  s <- scan(what =  "character", n = 1)
}
