with source as (
    select * from {{ ref('products') }}
),

renamed as (
    select
        product_id,
        product_name,
        category,
        price,
        cost,
        description,
        created_at,
        updated_at,
        price - cost as margin,
        (price - cost) / price as margin_percent
    from source
)

select * from renamed
