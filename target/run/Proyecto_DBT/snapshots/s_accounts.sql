
      update "postgres"."snapshots"."s_accounts"
    set dbt_valid_to = DBT_INTERNAL_SOURCE.dbt_valid_to
    from "s_accounts__dbt_tmp202224638024" as DBT_INTERNAL_SOURCE
    where DBT_INTERNAL_SOURCE.dbt_scd_id::text = "postgres"."snapshots"."s_accounts".dbt_scd_id::text
      and DBT_INTERNAL_SOURCE.dbt_change_type::text in ('update'::text, 'delete'::text)
      and "postgres"."snapshots"."s_accounts".dbt_valid_to is null;

    insert into "postgres"."snapshots"."s_accounts" ("account_id", "account_name", "account_type", "opening_date", "balance", "dbt_updated_at", "dbt_valid_from", "dbt_valid_to", "dbt_scd_id")
    select DBT_INTERNAL_SOURCE."account_id",DBT_INTERNAL_SOURCE."account_name",DBT_INTERNAL_SOURCE."account_type",DBT_INTERNAL_SOURCE."opening_date",DBT_INTERNAL_SOURCE."balance",DBT_INTERNAL_SOURCE."dbt_updated_at",DBT_INTERNAL_SOURCE."dbt_valid_from",DBT_INTERNAL_SOURCE."dbt_valid_to",DBT_INTERNAL_SOURCE."dbt_scd_id"
    from "s_accounts__dbt_tmp202224638024" as DBT_INTERNAL_SOURCE
    where DBT_INTERNAL_SOURCE.dbt_change_type::text = 'insert'::text;

  