
{{ config(materialized='table') }}

select 
t.*,
{{ dbt_utils.generate_surrogate_key(['transaction_id', 'account_id','transaction_date','transaction_amount','transaction_type','balance']) }} as hash_column
from {{ ref ('int_transactions') }}  t


{% if target.name == 'dev' %}
limit 500
{% endif %}

