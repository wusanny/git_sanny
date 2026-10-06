{{ config(materialized='table') }}

select * from {{ ref("foo") }}