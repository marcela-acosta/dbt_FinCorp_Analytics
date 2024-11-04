{{ config(materialized='table') }} 

select 
	transaction_date,
	account_id, 
    {{balance_acumulado('transaction_amount')}} as transaction_amount
from {{ ref ('int_transactions') }} t
group by 
	transaction_date,
	account_id


{% if target.name == 'dev' %}
limit 500
{% endif %}

