
      update "postgres"."snapshots"."s_account_type"
    set dbt_valid_to = DBT_INTERNAL_SOURCE.dbt_valid_to
    from "s_account_type__dbt_tmp202224503024" as DBT_INTERNAL_SOURCE
    where DBT_INTERNAL_SOURCE.dbt_scd_id::text = "postgres"."snapshots"."s_account_type".dbt_scd_id::text
      and DBT_INTERNAL_SOURCE.dbt_change_type::text in ('update'::text, 'delete'::text)
      and "postgres"."snapshots"."s_account_type".dbt_valid_to is null;

    insert into "postgres"."snapshots"."s_account_type" ("account_type_id", "account_type_name", "dbt_updated_at", "dbt_valid_from", "dbt_valid_to", "dbt_scd_id")
    select DBT_INTERNAL_SOURCE."account_type_id",DBT_INTERNAL_SOURCE."account_type_name",DBT_INTERNAL_SOURCE."dbt_updated_at",DBT_INTERNAL_SOURCE."dbt_valid_from",DBT_INTERNAL_SOURCE."dbt_valid_to",DBT_INTERNAL_SOURCE."dbt_scd_id"
    from "s_account_type__dbt_tmp202224503024" as DBT_INTERNAL_SOURCE
    where DBT_INTERNAL_SOURCE.dbt_change_type::text = 'insert'::text;

  