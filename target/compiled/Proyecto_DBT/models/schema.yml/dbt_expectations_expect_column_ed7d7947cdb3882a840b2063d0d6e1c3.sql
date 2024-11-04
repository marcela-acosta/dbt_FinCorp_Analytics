


    with grouped_expression as (
    select
        
        
    
  
count(distinct transaction_date) > 1
 as expression


    from "postgres"."dev_proyecto"."agg_daily_balance"
    

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


