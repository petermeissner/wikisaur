#' get_dino_list
#'
#' @export
#'
#' @import rvest
#' @import xml2
#' @import data.table
get_dino_list <- function(){
  tmp <-
    xml2::read_html("https://en.wikipedia.org/wiki/List_of_dinosaur_genera") %>%
    rvest::html_nodes("i a") %>%
    rvest::html_attrs() %>%
    lapply(
      function(x){
        as.data.frame(t(x))
      }
    ) %>%
    data.table::rbindlist(fill = TRUE)

  tmp$id <- tolower(gsub("/wiki/", "", tmp$href))
  tmp$source <- "https://en.wikipedia.org/wiki/List_of_dinosaur_genera"
  tmp[grepl("^/wiki/", tmp$href)]
}
