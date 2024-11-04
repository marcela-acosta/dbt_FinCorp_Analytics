

select 
t.*,
md5(cast(coalesce(cast(transaction_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(account_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(transaction_date as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(transaction_amount as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(transaction_type as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(balance as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as hash_column
from "postgres"."dev_proyecto"."int_transactions"  t



limit 500
