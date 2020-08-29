{{ config(materialized='table') }}

SELECT town_name, average_signal, magnitud, contaminant
FROM
{{ref("avg_signal")}} avg_signal,
{{ref("avg_contaminants")}} avg_contaminants
where town_name = municipi
order by town_name