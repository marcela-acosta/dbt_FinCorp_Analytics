select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from "postgres"."dev_proyecto_dbt_test__audit"."relationships_fact_transaction_0176b77139ac331ee379d579f7f90fc2"
    
      
    ) dbt_internal_test