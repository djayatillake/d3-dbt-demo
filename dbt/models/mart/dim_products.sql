{{
    config(
        materialized='table'
    )
}}

with product_performance as (
    select * from {{ ref('int_product_performance') }}
),

final as (
    select
        product_id,
        product_name,
        category,
        current_price,
        current_cost,
        current_margin,
        current_margin_percent,
        times_ordered,
        total_quantity_sold,
        total_revenue,
        total_cost,
        total_profit,
        profit_margin,
        first_order_date,
        last_order_date,
        datediff(day, first_order_date, last_order_date) as days_selling,
        datediff(day, last_order_date, current_date()) as days_since_last_order,
        case
            when total_quantity_sold = 0 then 'No Sales'
            when total_quantity_sold <= 10 then 'Low Seller'
            when total_quantity_sold <= 50 then 'Medium Seller'
            else 'High Seller'
        end as sales_tier,
        case
            when profit_margin < 0.2 then 'Low Margin'
            when profit_margin < 0.4 then 'Medium Margin'
            else 'High Margin'
        end as margin_tier
    from product_performance
)

select * from final
