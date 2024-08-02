{% snapshot snappy_snap_one %}

{{
    config(
      target_schema='snapshots',
      unique_key='this_is_unique',
      strategy='check',
      check_cols= 'all',
    )
}}

select
concat("ID",'_',"CODE") as this_is_unique,
id,
code,
first_name,
last_name
from {{ source('snap_source', 'snap_one') }}

{% endsnapshot %}

