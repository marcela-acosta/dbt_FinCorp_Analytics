
{{ config(materialized='table') }}

select 
t.*, a.balance
from {{ ref ('stg_transactions') }} t
    left join {{ ref ('stg_accounts') }} a on t.account_id = a.account_id


{% if target.name == 'dev' %}
limit 500
{% endif %}

