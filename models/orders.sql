select * from {{ source("jaffle_shop", "orders") }}
order by _etl_loaded_at asc