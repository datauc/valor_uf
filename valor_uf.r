#definir función con un método principal y otro secundario por si acaso
calcular_uf <- function() {
#scrapping principal
valor_uf <- rvest::html_session("https://valoruf.cl") %>% 
  rvest::html_nodes(".vpr") %>% 
  rvest::html_text() %>%
  stringr::str_remove("\\.") %>%
  stringr::str_replace(",", ".") %>%
  readr::parse_number()

#confirmar que funcionó
if (is.numeric(valor_uf) & valor_uf > 10000) {
  valor_uf <- valor_uf
} else {
  #scrapping secundario
  valor_uf <- rvest::html_session("https://www.uf-hoy.com") %>%
    rvest::html_nodes("#valor_uf") %>% 
    rvest::html_text() %>%
    stringr::str_remove("\\.") %>%
    stringr::str_replace(",", ".") %>%
    readr::parse_number()
}
return(valor_uf)
}

valor_uf <- calcular_uf()
