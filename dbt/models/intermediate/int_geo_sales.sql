with orders as (
    select * from {{ ref('int_order_details') }}
),

geo_sales as (
    select
        shipping_country,
        shipping_state,
        shipping_city,
        count(distinct order_id) as number_of_orders,
        sum(total_quantity) as total_items_sold,
        sum(total_gross_amount) as gross_revenue,
        sum(total_discounts) as total_discounts,
        sum(total_net_amount) as net_revenue,
        sum(shipping_cost) as total_shipping_cost,
        sum(order_total_with_shipping) as total_revenue_with_shipping,
        sum(total_cost) as total_cost,
        sum(total_profit) as total_profit,
        avg(profit_margin) as avg_profit_margin,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date
    from orders
    group by 1, 2, 3
)

select * from geo_sales
