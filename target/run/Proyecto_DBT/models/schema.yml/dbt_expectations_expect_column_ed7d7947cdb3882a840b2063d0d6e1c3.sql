select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from "postgres"."dev_proyecto_dbt_test__audit"."dbt_expectations_expect_column_ed7d7947cdb3882a840b2063d0d6e1c3"
    
      
    ) dbt_internal_test