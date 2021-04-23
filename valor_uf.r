# UF del día de hoy ----

#función que obtiene el valor de la UF del día actual haciendo web scrapping en el sitio valoruf.cl
#en caso de que dicho scrapping falle, se hace scrapping en el sitio uf-hoy.com

#definir función con un método principal y otro secundario por si acaso
calcular_uf_hoy <- function() {
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

#valor_uf <- calcular_uf_hoy()




# UF del año ----

#función que realiza un scrapping del sitio del SII que tiene los valores de la UF:
#https://www.sii.cl/valores_y_fechas/uf/uf2021.htm
#El único argumento a definir es el año que se solicita

calcular_uf_anual <- function(año_elegido = 2020) {
  #obtener sitio y hacer scrapping
  tablas <- xml2::read_html(paste0("https://www.sii.cl/valores_y_fechas/uf/uf", año_elegido, ".htm#")) %>% 
    rvest::html_table(fill = TRUE)
  
  valores_uf_anuales <- tablas[13] %>% #la última tiene todos los meses
    as.data.frame() %>%
    rename(dia = 1) %>%
    tidyr::pivot_longer(cols = 2:13, names_to = "mes", values_to = "valor") %>%
    #crear fecha
    mutate(año = año_elegido) %>%
    mutate(fecha = paste(mes, dia, año),
           fecha = lubridate::mdy(fecha)) %>%
    mutate(mes_original = mes,
           mes = lubridate::month(fecha)) %>%
    na.omit() %>% #ignorar días inválidos de la tabla
    #arreglar cifra
    mutate(valor = stringr::str_remove(valor, "\\."),
           valor = stringr::str_replace(valor, ",", "."),
           valor = readr::parse_number(valor))
  
  return(valores_uf_anuales)
}

#valores_uf_2021 <- calcular_uf_anual(2021)
#valores_uf_2015 <- calcular_uf_anual(2015)
