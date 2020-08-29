{{ config(materialized='table') }}
SELECT municipi, AVG(magnitud) magnitud, CONTAMINANT FROM
`warehouse.emissions`
GROUP BY CONTAMINANT, municipi