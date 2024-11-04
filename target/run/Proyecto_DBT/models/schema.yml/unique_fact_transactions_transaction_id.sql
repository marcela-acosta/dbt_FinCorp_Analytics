select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from "postgres"."dev_proyecto_dbt_test__audit"."unique_fact_transactions_transaction_id"
    
      
    ) dbt_internal_test