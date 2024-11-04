select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from "postgres"."dev_proyecto_dbt_test__audit"."dbt_expectations_expect_column_0d825628f862a9b720cbcf389ec61059"
    
      
    ) dbt_internal_test