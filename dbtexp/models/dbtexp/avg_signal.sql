{{ config(materialized='table') }}

SELECT AVG(signal) average_signal, town_name
FROM `warehouse.mobile_data_2015_2017`
group by town_name
order by average_signal asc