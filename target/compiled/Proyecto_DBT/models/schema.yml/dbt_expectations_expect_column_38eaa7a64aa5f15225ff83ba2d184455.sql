


    with grouped_expression as (
    select
        
        
    
  
count(distinct ) > 1000
 as expression


    from "postgres"."dev_proyecto"."dim_accounts"
    

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


