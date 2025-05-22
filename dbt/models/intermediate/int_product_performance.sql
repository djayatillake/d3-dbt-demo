with products as (
    select * from {{ ref('stg_products') }}
),

order_items as (
    select * from {{ ref('stg_order_items') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

product_orders as (
    select
        oi.product_id,
        o.order_date,
        oi.quantity,
        oi.price,
        oi.discount,
        oi.total_amount
    from order_items oi
    inner join orders o on oi.order_id = o.order_id
),

product_performance as (
    select
        p.product_id,
        p.product_name,
        p.category,
        p.price as current_price,
        p.cost as current_cost,
        p.margin as current_margin,
        p.margin_percent as current_margin_percent,
        count(po.product_id) as times_ordered,
        sum(po.quantity) as total_quantity_sold,
        sum(po.total_amount) as total_revenue,
        sum(po.quantity * p.cost) as total_cost,
        sum(po.total_amount) - sum(po.quantity * p.cost) as total_profit,
        (sum(po.total_amount) - sum(po.quantity * p.cost)) / nullif(sum(po.total_amount), 0) as profit_margin,
        min(po.order_date) as first_order_date,
        max(po.order_date) as last_order_date
    from products p
    left join product_orders po on p.product_id = po.product_id
    group by 1, 2, 3, 4, 5, 6, 7
)

select * from product_performance
