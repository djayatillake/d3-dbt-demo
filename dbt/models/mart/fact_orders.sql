{{
    config(
        materialized='table'
    )
}}

with order_details as (
    select * from {{ ref('int_order_details') }}
),

final as (
    select
        order_id,
        customer_id,
        order_date,
        date_trunc('month', order_date) as order_month,
        date_trunc('week', order_date) as order_week,
        date_part('year', order_date) as order_year,
        date_part('month', order_date) as month_number,
        date_part('quarter', order_date) as quarter_number,
        status,
        payment_method,
        shipping_city,
        shipping_state,
        shipping_country,
        shipping_cost,
        total_amount,
        order_total_with_shipping,
        number_of_items,
        total_quantity,
        total_gross_amount,
        total_discounts,
        total_net_amount,
        total_cost,
        total_profit,
        profit_margin,
        case
            when total_net_amount < 50 then 'Small Order'
            when total_net_amount < 150 then 'Medium Order'
            else 'Large Order'
        end as order_size,
        case
            when profit_margin < 0.2 then 'Low Margin'
            when profit_margin < 0.4 then 'Medium Margin'
            else 'High Margin'
        end as margin_tier
    from order_details
)

select * from final
