with source as (
    select * from {{ ref('orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        order_date,
        status,
        total_amount,
        payment_method,
        shipping_address,
        shipping_city,
        shipping_state,
        shipping_country,
        shipping_cost,
        total_amount + shipping_cost as order_total_with_shipping
    from source
)

select * from renamed
