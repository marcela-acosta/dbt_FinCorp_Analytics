select 
 *
 from {{ source('raw_data','transactions') }}


{% if target.name == 'dev' %}
limit 600
{% endif %}
