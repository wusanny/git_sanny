{{ config(
    tags=["bananas"]
) }}

select * from {{ref("foo")}}