# valor_uf

Funciones para obtener el precio de la UF en R. 

La primera función, `calcular_uf_hoy()`, obtiene el valor de la UF del día actual mediante el uso de web scrapping en el sitio valoruf.cl, y en caso de que dicho scrapping falle, se hace scrapping en el sitio uf-hoy.com. 

Ejemplo de uso:
```
valor_uf <- calcular_uf_hoy()
```

La segunda función, `calcular_uf_anual()`, entrega una tabla de todos los valores de la UF en cada día del año especificado. Por ejemplo, si se usa `calcular_uf_anual(2020)`, se obtendrá un data frame con 365 filas con cada valor de la UF para cada día. Los datos se obtienen del [sitio oficial del Servicio de Impuestos Internos (SII).](https://www.sii.cl/valores_y_fechas/index_valores_y_fechas.html)

```
valores_uf_2017 <- calcular_uf_anual(2017)
```

Se utiliza `dplyr` para el flujo de trabajo, el paquete `rvest` para hacer el scrapping, `stringr` para limpiar el output, `lubridate` para las fechas, y finalmente `readr` para transformar los output a valores numéricos.

