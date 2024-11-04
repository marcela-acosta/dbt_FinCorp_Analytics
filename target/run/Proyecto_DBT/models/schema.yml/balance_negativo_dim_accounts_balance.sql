select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from "postgres"."dev_proyecto_dbt_test__audit"."balance_negativo_dim_accounts_balance"
    
      
    ) dbt_internal_test