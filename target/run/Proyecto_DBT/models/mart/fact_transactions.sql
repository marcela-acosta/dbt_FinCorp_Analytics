
  
    

  create  table "postgres"."dev_proyecto"."fact_transactions__dbt_tmp"
  
  
    
  
  (
    transaction_id int primary key,
    account_id int,
    transaction_date date,
    transaction_amount int,
    transaction_type TEXT,
    balance int,
    hash_column TEXT
    
    )
 ;
    insert into "postgres"."dev_proyecto"."fact_transactions__dbt_tmp" (
      transaction_id, account_id, transaction_date, transaction_amount, transaction_type, balance, hash_column
    )
  
  (
    
    select transaction_id, account_id, transaction_date, transaction_amount, transaction_type, balance, hash_column
    from (
        

select 
t.*,
md5(cast(coalesce(cast(transaction_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(account_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(transaction_date as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(transaction_amount as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(transaction_type as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(balance as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as hash_column
from "postgres"."dev_proyecto"."int_transactions"  t



limit 500

    ) as model_subq
  );
  