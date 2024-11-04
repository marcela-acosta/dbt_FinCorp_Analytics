

select 
a.*,
md5(cast(coalesce(cast(account_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(account_name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(account_type as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(opening_date as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(balance as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(account_type_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as hash_column
from "postgres"."dev_proyecto"."int_accounts" a



limit 500
