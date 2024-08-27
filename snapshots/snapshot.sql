{% snapshot customer_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='id',
      strategy='check',
      check_cols=['customer', 'time_now', 'colour', 'age']
    )
}}

select * from {{ source('super_source', 'source') }}

{% endsnapshot %}