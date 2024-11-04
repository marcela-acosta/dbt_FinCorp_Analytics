
  create view "postgres"."dev_proyecto"."stg_account_types__dbt_tmp"
    
    
  as (
    select 
 *
 from "postgres"."raw_data"."account_types"

limit 600

  );