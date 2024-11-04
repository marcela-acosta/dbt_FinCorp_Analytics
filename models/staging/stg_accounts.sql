select 
 *
 from {{ source('raw_data','accounts') }}


{% if target.name == 'dev' %}
limit 600
{% endif %}
