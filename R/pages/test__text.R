#* @filter cors
cors <- function(res) {
    res$setHeader("Access-Control-Allow-Origin", "*")
    plumber::forward()
}

#' @preempt cors
#' Endpoint that bypasses serialization
#' @get /text
function(res){
  res$body <- "Literal text here!"
  cors(res)
  res
}
