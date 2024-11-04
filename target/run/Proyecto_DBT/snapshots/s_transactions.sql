
      update "postgres"."snapshots"."s_transactions"
    set dbt_valid_to = DBT_INTERNAL_SOURCE.dbt_valid_to
    from "s_transactions__dbt_tmp202224724024" as DBT_INTERNAL_SOURCE
    where DBT_INTERNAL_SOURCE.dbt_scd_id::text = "postgres"."snapshots"."s_transactions".dbt_scd_id::text
      and DBT_INTERNAL_SOURCE.dbt_change_type::text in ('update'::text, 'delete'::text)
      and "postgres"."snapshots"."s_transactions".dbt_valid_to is null;

    insert into "postgres"."snapshots"."s_transactions" ("transaction_id", "account_id", "transaction_date", "transaction_amount", "transaction_type", "dbt_updated_at", "dbt_valid_from", "dbt_valid_to", "dbt_scd_id")
    select DBT_INTERNAL_SOURCE."transaction_id",DBT_INTERNAL_SOURCE."account_id",DBT_INTERNAL_SOURCE."transaction_date",DBT_INTERNAL_SOURCE."transaction_amount",DBT_INTERNAL_SOURCE."transaction_type",DBT_INTERNAL_SOURCE."dbt_updated_at",DBT_INTERNAL_SOURCE."dbt_valid_from",DBT_INTERNAL_SOURCE."dbt_valid_to",DBT_INTERNAL_SOURCE."dbt_scd_id"
    from "s_transactions__dbt_tmp202224724024" as DBT_INTERNAL_SOURCE
    where DBT_INTERNAL_SOURCE.dbt_change_type::text = 'insert'::text;

  