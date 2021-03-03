
TEMPDIR <- "cache" #either 'cache' for 'permanent' cache or tempdir() for session only cache
TRACE <- TRUE
ALLOW_UPDATE <- TRUE ## flag for update button display

shinycat <-function(...) {
	if (TRACE) cat(...)
}
shinyprint <-function(...) print(...)

wait <- function(msg = "Click to continue...") {
  print(msg)
  s <- scan(what =  "character", n = 1)
}
