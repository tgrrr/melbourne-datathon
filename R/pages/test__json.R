# TODO:
#* @filter cors
cors <- function(res) {
    res$setHeader("Access-Control-Allow-Origin", "*")
    plumber::forward()
}

#* @get /testjson
#* @serializer unboxedJSON
TestJson <- function() {
  data_output <- 'foo'
  list('response' = data_output)
}
