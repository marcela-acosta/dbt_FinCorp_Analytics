
  
    

  create  table "postgres"."dev_proyecto"."int_daily_balance__dbt_tmp"
  
  
    as
  
  (
     

select 
	transaction_date,
	account_id, 
    
   
    sum(transaction_amount)
   
 as transaction_amount
from "postgres"."dev_proyecto"."int_transactions" t
group by 
	transaction_date,
	account_id



limit 500

  );
  