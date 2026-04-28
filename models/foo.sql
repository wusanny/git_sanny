{{
  config(
    materialized='incremental',
    cluster_by=['id']
  )
}}

select * from {{ ref ('bar') }}
group by 1