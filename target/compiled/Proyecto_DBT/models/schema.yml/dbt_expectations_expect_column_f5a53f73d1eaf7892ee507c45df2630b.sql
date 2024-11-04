


    with grouped_expression as (
    select
        
        
    
  
count(distinct transaction_id) > 1
 as expression


    from "postgres"."dev_proyecto"."fact_transactions"
    

),
validation_errors as (

    select
        *
    from
        grouped_expression
    where
        not(expression = true)

)

select *
from validation_errors


