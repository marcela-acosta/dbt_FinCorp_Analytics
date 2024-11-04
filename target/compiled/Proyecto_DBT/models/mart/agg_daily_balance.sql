

select 
ag.*,
md5(cast(coalesce(cast(transaction_date as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(account_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(transaction_amount as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as hash_column
from "postgres"."dev_proyecto"."int_daily_balance" ag


    where transaction_date >= (select coalesce(max(transaction_date),'1900-01-01') from "postgres"."dev_proyecto"."agg_daily_balance")




limit 500
