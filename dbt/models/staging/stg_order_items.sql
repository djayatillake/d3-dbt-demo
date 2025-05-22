with source as (
    select * from {{ ref('order_items') }}
),

renamed as (
    select
        order_item_id,
        order_id,
        product_id,
        quantity,
        price,
        discount,
        total_amount,
        price * quantity as gross_amount,
        discount * quantity as total_discount,
        (price * quantity) - (discount * quantity) as net_amount
    from source
)

select * from renamed
