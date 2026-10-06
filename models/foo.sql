{{ config(
    materialized='incremental',
    unique_key='user_id',
    incremental_strategy='merge'
) }}

{% set last_received %}
  {%- if is_incremental() and execute -%}
    {%- set result = run_query("select max(_src_received_at) from " ~ this) -%}
    '{{ result.columns[0].values()[0] }}'
  {%- else -%}
    '1900-01-01'
  {%- endif -%}
{% endset %}

select
    user_id,
    name,
    _metadata.file_name as _file_name,
    _metadata.file_modification_time as _src_received_at
from read_files(
    "s3://user-id-bucket-list-sanny-test/user_id_list.csv",
    format => "csv",
    header => "true"
)
where _metadata.file_modification_time >= {{ last_received | trim }}