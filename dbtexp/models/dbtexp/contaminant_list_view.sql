{{ config(materialized='view') }}
{% set contaminants = ["O3", "NO", "NO2"] %}
SELECT
{% for contaminat in contaminants %}
sum(case when contaminant = '{{contaminat}}' then magnitud end) as {{contaminat}}_amount,
    {% endfor %}
FROM
{{ref("avg_signal_contaminant")}} avg_signal_contaminant
