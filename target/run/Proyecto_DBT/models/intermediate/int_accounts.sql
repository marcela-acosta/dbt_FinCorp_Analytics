
  
    

  create  table "postgres"."dev_proyecto"."int_accounts__dbt_tmp"
  
  
    as
  
  (
    

select 
acc.*, act.account_type_id
from "postgres"."dev_proyecto"."stg_accounts" acc
    left join "postgres"."dev_proyecto"."stg_account_types" act on acc.account_type = act.account_type_name



limit 500

  );
  