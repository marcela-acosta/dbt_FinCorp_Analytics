

select 
t.*, a.balance
from "postgres"."dev_proyecto"."stg_transactions" t
    left join "postgres"."dev_proyecto"."stg_accounts" a on t.account_id = a.account_id



limit 500
