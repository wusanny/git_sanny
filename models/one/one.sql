{{ config(
    pre_hook=["use schema {{ generate_database_name() }}.{{ target.schema }}"]
) }}

select 1 as onetwo