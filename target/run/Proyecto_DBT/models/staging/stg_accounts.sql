
  create view "postgres"."dev_proyecto"."stg_accounts__dbt_tmp"
    
    
  as (
    select 
 *
 from "postgres"."raw_data"."accounts"



limit 600

  );