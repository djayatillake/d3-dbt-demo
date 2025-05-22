with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('int_order_details') }}
),

customer_order_history as (
    select
        c.customer_id,
        c.first_name,
        c.last_name,
        c.full_name,
        c.email,
        c.city,
        c.state,
        c.country,
        c.created_at as customer_created_at,
        c.updated_at as customer_updated_at,
        count(distinct o.order_id) as number_of_orders,
        min(o.order_date) as first_order_date,
        max(o.order_date) as last_order_date,
        sum(o.total_net_amount) as lifetime_value,
        sum(o.total_profit) as lifetime_profit,
        sum(o.shipping_cost) as total_shipping_cost,
        avg(o.total_net_amount) as avg_order_value,
        sum(o.number_of_items) as total_items_purchased,
        sum(o.total_quantity) as total_quantity_purchased
    from customers c
    left join orders o on c.customer_id = o.customer_id
    group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
)

select * from customer_order_history
