select 
	transaction_date,
	account_id, 
    
   
    sum(transaction_amount)
   
 as transaction_amount
from "postgres"."dev_proyecto"."int_daily_balance" ag
group by 
	transaction_date,
	account_id