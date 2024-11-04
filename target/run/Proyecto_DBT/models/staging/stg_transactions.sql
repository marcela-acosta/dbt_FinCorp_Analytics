
  create view "postgres"."dev_proyecto"."stg_transactions__dbt_tmp"
    
    
  as (
    select 
 *
 from "postgres"."raw_data"."transactions"



limit 600

  );