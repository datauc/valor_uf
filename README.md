# valor_uf

Función de R que obtiene el valor de la UF del día actual mediante el uso de web scrapping en el sitio valoruf.cl, y en caso de que dicho scrapping falle, se hace scrapping en el sitio uf-hoy.com.

Se utiliza `dplyr` para el flujo de trabajo, el paquete `rvest` para hacer el scrapping, `stringr` para limpiar el output, y finalmente `readr` para transformar el output a un valor numérico.

El uso recomendado es usar `source("valor_uf.r")` para ejecutar el archivo, obtener la función `calcular_uf()` y un objeto llamado `valor_uf` que contiene el valor al día de la UF.
