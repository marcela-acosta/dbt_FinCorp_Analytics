select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from "postgres"."dev_proyecto_dbt_test__audit"."dbt_expectations_expect_column_f5a53f73d1eaf7892ee507c45df2630b"
    
      
    ) dbt_internal_test