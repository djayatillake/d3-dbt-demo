{{
    config(
        materialized='table'
    )
}}

with geo_sales as (
    select * from {{ ref('int_geo_sales') }}
),

final as (
    select
        shipping_country,
        shipping_state,
        shipping_city,
        number_of_orders,
        total_items_sold,
        gross_revenue,
        total_discounts,
        net_revenue,
        total_shipping_cost,
        total_revenue_with_shipping,
        total_cost,
        total_profit,
        avg_profit_margin,
        first_order_date,
        last_order_date,
        datediff(day, first_order_date, last_order_date) as days_with_sales,
        case
            when net_revenue < 1000 then 'Low Revenue'
            when net_revenue < 5000 then 'Medium Revenue'
            else 'High Revenue'
        end as revenue_tier,
        case
            when avg_profit_margin < 0.2 then 'Low Margin'
            when avg_profit_margin < 0.4 then 'Medium Margin'
            else 'High Margin'
        end as margin_tier
    from geo_sales
)

select * from final
