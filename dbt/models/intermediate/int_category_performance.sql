with product_performance as (
    select * from {{ ref('int_product_performance') }}
),

category_performance as (
    select
        category,
        count(distinct product_id) as number_of_products,
        sum(times_ordered) as total_orders,
        sum(total_quantity_sold) as total_quantity_sold,
        sum(total_revenue) as total_revenue,
        sum(total_cost) as total_cost,
        sum(total_profit) as total_profit,
        sum(total_profit) / nullif(sum(total_revenue), 0) as overall_profit_margin,
        avg(current_margin_percent) as average_margin_percent,
        min(first_order_date) as first_order_date,
        max(last_order_date) as last_order_date
    from product_performance
    group by 1
)

select * from category_performance
