
      
        
            delete from "postgres"."dev_proyecto"."agg_daily_balance"
            using "agg_daily_balance__dbt_tmp214658028496"
            where (
                
                    "agg_daily_balance__dbt_tmp214658028496".transaction_date = "postgres"."dev_proyecto"."agg_daily_balance".transaction_date
                    and 
                
                    "agg_daily_balance__dbt_tmp214658028496".account_id = "postgres"."dev_proyecto"."agg_daily_balance".account_id
                    
                
                
            );
        
    

    insert into "postgres"."dev_proyecto"."agg_daily_balance" ("transaction_date", "account_id", "transaction_amount", "hash_column")
    (
        select "transaction_date", "account_id", "transaction_amount", "hash_column"
        from "agg_daily_balance__dbt_tmp214658028496"
    )
  