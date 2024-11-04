select 
 *
 from {{ source('raw_data','account_types') }}
{% if target.name == 'dev' %}
limit 600
{% endif %}