{{ config(materialized='incremental',
         unique_key = ['transaction_date', 'account_id'],
         on_schema_change = 'append_new_columns'
    ) }}

select 
ag.*,
{{ dbt_utils.generate_surrogate_key(['transaction_date', 'account_id','transaction_amount']) }} as hash_column
from {{ ref ('int_daily_balance') }} ag

{% if is_incremental() %}
    where transaction_date >= (select coalesce(max(transaction_date),'1900-01-01') from {{ this }})
{% endif %}


{% if target.name == 'dev' %}
limit 500
{% endif %}



