select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from "postgres"."dev_proyecto_dbt_test__audit"."dbt_expectations_expect_column_d945e07a3cd92c9b2dfb04deadc91d78"
    
      
    ) dbt_internal_test