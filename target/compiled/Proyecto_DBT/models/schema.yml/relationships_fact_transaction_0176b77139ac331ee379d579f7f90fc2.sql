
    
    

with child as (
    select account_id as from_field
    from "postgres"."dev_proyecto"."fact_transactions"
    where account_id is not null
),

parent as (
    select account_id as to_field
    from "postgres"."dev_proyecto"."dim_accounts"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


