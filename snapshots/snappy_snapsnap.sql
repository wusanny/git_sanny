{% snapshot snappy_snapsnap %}

{{
    config(
      target_schema='snapshots',
      unique_key='id',
      strategy='check',
      check_cols= 'all',
    )
}}

select * from {{ source('jaffle_shop', 'orders') }}

{% endsnapshot %}

