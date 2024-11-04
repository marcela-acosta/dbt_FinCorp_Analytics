
  
    

  create  table "postgres"."dev_proyecto"."dim_accounts__dbt_tmp"
  
  
    
  
  (
    account_id int primary key,
    account_name TEXT,
    account_type TEXT,
    opening_date date,
    balance int,
    account_type_id int,
    hash_column TEXT
    
    )
 ;
    insert into "postgres"."dev_proyecto"."dim_accounts__dbt_tmp" (
      account_id, account_name, account_type, opening_date, balance, account_type_id, hash_column
    )
  
  (
    
    select account_id, account_name, account_type, opening_date, balance, account_type_id, hash_column
    from (
        

select 
a.*,
md5(cast(coalesce(cast(account_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(account_name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(account_type as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(opening_date as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(balance as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(account_type_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as hash_column
from "postgres"."dev_proyecto"."int_accounts" a



limit 500

    ) as model_subq
  );
  