#' List available tables from a given GA4GH search API endpoint.
#'
#' @param url The base URL of the GA4GH Search API Implementation.
#' @return A data frame with the table name and data model, or reference to data model.
#' @export
explorer_list_tables <- function(url, collectionslug){
  r <- httr::GET(paste(url,"/api/collections/",collectionslug,"/data-connect/tables", sep=""), httr::content_type("application/json"));
  json <- jsonlite::fromJSON(httr::content(r, "text"));
  return(json);
}

#' Execute a search against a GA4GH Search API implementation located at the given URL.
#'
#' @param url The base URL of the GA4GH Search API Implementation.
#' @param query The SQL query to execute
#' @return A data frame with ALL search results where columns correspond to the top level of search properties returned by the API.
#' @export
explorer_search <- function(url, collectionslug, query){
  r <- httr::POST(paste(url,"/api/collections/",collectionslug,"/data-connect/search", sep=""), "body"=paste("{\"query\":\"", query, "\"}", sep=""), httr::content_type("application/json"));
  json <- jsonlite::fromJSON(httr::content(r, "text"));

  df <- data.frame()
  while(!is.null(json$pagination$next_page_url)){
    cat(".")
    if(is.list(json$data) && length(json$data)>0){
      df<-rbind(df, json$data)
    }
    r <- httr::GET(json$pagination$next_page_url, httr::content_type("application/json"));
    json <- jsonlite::fromJSON(httr::content(r, "text"));
  }

  if(is.list(json$data) && length(json$data)>0){
    df<-rbind(df, json$data)
  }
  return(df);
}
