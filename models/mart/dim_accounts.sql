{{ config(materialized='table') }}

select 
a.*,
{{ dbt_utils.generate_surrogate_key(['account_id', 'account_name','account_type','opening_date','balance','account_type_id']) }} as hash_column
from {{ ref ('int_accounts') }} a


{% if target.name == 'dev' %}
limit 500
{% endif %}

