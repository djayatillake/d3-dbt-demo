{{
    config(
        materialized='table'
    )
}}

SELECT 
    id,
    name,
    created_at,
    updated_at
FROM source('source_schema', 'source_table')
