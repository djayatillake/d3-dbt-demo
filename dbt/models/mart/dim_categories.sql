{{
    config(
        materialized='table'
    )
}}

with category_performance as (
    select * from {{ ref('int_category_performance') }}
),

final as (
    select
        category,
        number_of_products,
        total_orders,
        total_quantity_sold,
        total_revenue,
        total_cost,
        total_profit,
        overall_profit_margin,
        average_margin_percent,
        first_order_date,
        last_order_date,
        datediff(day, first_order_date, last_order_date) as days_selling,
        datediff(day, last_order_date, current_date()) as days_since_last_order,
        case
            when total_revenue = 0 then 'No Revenue'
            when total_revenue < 1000 then 'Low Revenue'
            when total_revenue < 5000 then 'Medium Revenue'
            else 'High Revenue'
        end as revenue_tier,
        case
            when overall_profit_margin < 0.2 then 'Low Margin'
            when overall_profit_margin < 0.4 then 'Medium Margin'
            else 'High Margin'
        end as margin_tier
    from category_performance
)

select * from final
