#* @filter cors
cors <- function(res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  plumber::forward()
}

#' @preempt cors
#' @get /foo
#' @html
function(){
  "<html><h1>foo hello world</h1></html>"
}

foo <- data.frame(replicate(10,sample(0:1,1000,rep=TRUE)))

#' @get /bar
#' @serializer unboxedJSON
function(res){
  res$setHeader("Access-Control-Allow-Origin", "*")
  res$body <-
    list(
      status = "SUCCESS",
      code = "200",
      output = "foo"
        )
  res
}
