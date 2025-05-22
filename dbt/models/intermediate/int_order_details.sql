with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select * from {{ ref('stg_order_items') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

order_items_with_products as (
    select
        oi.order_item_id,
        oi.order_id,
        oi.product_id,
        oi.quantity,
        oi.price,
        oi.discount,
        oi.total_amount,
        oi.gross_amount,
        oi.total_discount,
        oi.net_amount,
        p.product_name,
        p.category,
        p.cost,
        p.margin,
        p.margin_percent,
        (oi.quantity * p.cost) as total_cost,
        oi.net_amount - (oi.quantity * p.cost) as item_profit
    from order_items oi
    left join products p on oi.product_id = p.product_id
),

order_details as (
    select
        o.order_id,
        o.customer_id,
        o.order_date,
        o.status,
        o.payment_method,
        o.shipping_address,
        o.shipping_city,
        o.shipping_state,
        o.shipping_country,
        o.shipping_cost,
        o.total_amount,
        o.order_total_with_shipping,
        count(oip.order_item_id) as number_of_items,
        sum(oip.quantity) as total_quantity,
        sum(oip.gross_amount) as total_gross_amount,
        sum(oip.total_discount) as total_discounts,
        sum(oip.net_amount) as total_net_amount,
        sum(oip.total_cost) as total_cost,
        sum(oip.item_profit) as total_profit,
        sum(oip.item_profit) / nullif(sum(oip.net_amount), 0) as profit_margin
    from orders o
    left join order_items_with_products oip on o.order_id = oip.order_id
    group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
)

select * from order_details
