{{ config(materialized='table') }}

select 
acc.*, act.account_type_id
from {{ ref ('stg_accounts') }} acc
    left join {{ ref ('stg_account_types') }} act on acc.account_type = act.account_type_name


{% if target.name == 'dev' %}
limit 500
{% endif %}

