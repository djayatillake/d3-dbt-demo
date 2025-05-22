{{
    config(
        materialized='table'
    )
}}

with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select * from {{ ref('stg_order_items') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

final as (
    select
        oi.order_item_id,
        oi.order_id,
        o.customer_id,
        oi.product_id,
        p.category,
        o.order_date,
        date_trunc('month', o.order_date) as order_month,
        date_trunc('week', o.order_date) as order_week,
        date_part('year', o.order_date) as order_year,
        date_part('month', o.order_date) as month_number,
        date_part('quarter', o.order_date) as quarter_number,
        o.status,
        o.payment_method,
        o.shipping_city,
        o.shipping_state,
        o.shipping_country,
        oi.quantity,
        oi.price,
        oi.discount,
        oi.total_amount,
        oi.gross_amount,
        oi.total_discount,
        oi.net_amount,
        p.cost as unit_cost,
        p.cost * oi.quantity as total_cost,
        oi.net_amount - (p.cost * oi.quantity) as profit,
        (oi.net_amount - (p.cost * oi.quantity)) / nullif(oi.net_amount, 0) as profit_margin
    from order_items oi
    inner join orders o on oi.order_id = o.order_id
    inner join products p on oi.product_id = p.product_id
)

select * from final
