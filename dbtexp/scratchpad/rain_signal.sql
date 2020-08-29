{{ config(materialized='table') }}

SELECT
  MET.codi_estacio,
  EST.nom_estacio,
  EST.nom_municipi,
  COB.date AS fecha_lectura_valor_cobertura,
  MET.valor_lectura AS valor_precipitacion,
  COB.network,
  COB.operator,
  COB.signal,
  COB.net
FROM
`warehouse.meteo` as MET, --tabla de meteorologica
`warehouse.meteo_metadata` as MET_MET, --tabla de metadatos de meteorologia
`warehouse.estacions` as EST, --tabla de telemetria meteorologica
`warehouse.mobile_data_2015_2017` as COB --tabla de cobertura de moviles
WHERE
  --  conexiones activas
  net IS NOT NULL
  -- JOIN entre estaciones y sus lecturas
  AND EST.codi_estacio = MET.codi_estacio
  -- nos quedamos con la lectura de la intensidad de lluvia (codigo)
  AND MET.codi_variable = MET_MET.codi_variable
  AND MET_MET.NOM_VARIABLE = 'Precipitació'
  -- dias en los que esta lloviendo
  AND valor_lectura > 0
  AND COB.date = MET.data_lectura
  -- nos quedamos con las lecturas de telefonia alrededor de 30 mins de la lectura del tiempo
  AND ABS(TIME_DIFF(COB.hour,
      hora_lectura,
      MINUTE)) < 30
  -- nos quedamos con las conexiones que ocurren a 1Km de la estacion meteorologica
  AND ST_DWITHIN(ST_GEOGPOINT(longitud,
      latitud),
    ST_GEOGPOINT(long,
      lat),
    1000)
ORDER BY
  data_lectura DESC LIMIT 100