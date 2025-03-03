{{ config(
    tags=["banana"]
) }}

select * from {{ref("foo")}}