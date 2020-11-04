{{ config(materialized='view') }}
SELECT *
FROM
{{ref("avg_signal_contaminant")}} avg_signal_contaminant
where town_name = 'Barcelona'
