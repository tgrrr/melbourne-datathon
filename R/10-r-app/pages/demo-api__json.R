crimes_weighted <- read_csv("~/code/data-science/melbourne-datathon/data/crimes_weighted.csv")
head(crimes_weighted)



#' @get /demo
#' @serializer unboxedJSON
function(res){
  res$setHeader("Access-Control-Allow-Origin", "*")
    res$body <-
      list(
        status = "SUCCESS",
        code = "200",
        output = crimes_weighted
          )
}
