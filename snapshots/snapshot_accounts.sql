{% snapshot snapshot_accounts %}


{{
    config(
        target_database = 'postgres',
        target_schema = 'snapshots',
        unique_key = 'account_id',
        strategy = 'check',
        check_cols = ['account_name','account_type','opening_date','balance']
    )

}}

select 
 *
 from {{ source('raw_data','accounts') }}

{% endsnapshot %}