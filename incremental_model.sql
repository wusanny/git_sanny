-- {{
--     config(
--         materialized='incremental'
--     )
-- }}

-- select 
-- *,
-- system$wait(60) as c 
-- from {{ ref('stg_orders') }}

-- {% if is_incremental() %}

--   -- this filter will only be applied on an incremental run
--   -- (uses >= to include records whose timestamp occurred since the last run of this model)
--   -- (If event_time is NULL or the table is truncated, the condition will always be true and load all records)
-- where _etl_loaded_at >= (select coalesce(max(_etl_loaded_at),'1900-01-01'::TIMESTAMP) from {{ this }} )

-- {% endif %}