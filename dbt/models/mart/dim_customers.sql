{{
    config(
        materialized='table'
    )
}}

with customer_orders as (
    select * from {{ ref('int_customer_orders') }}
),

final as (
    select
        customer_id,
        first_name,
        last_name,
        full_name,
        email,
        city,
        state,
        country,
        customer_created_at,
        customer_updated_at,
        number_of_orders,
        first_order_date,
        last_order_date,
        datediff(day, first_order_date, last_order_date) as customer_lifetime_days,
        datediff(day, last_order_date, current_date()) as days_since_last_order,
        lifetime_value,
        lifetime_profit,
        total_shipping_cost,
        avg_order_value,
        total_items_purchased,
        total_quantity_purchased,
        case 
            when number_of_orders = 0 then 'No Orders'
            when number_of_orders = 1 then 'One-Time'
            when number_of_orders = 2 then 'Repeat'
            else 'Loyal'
        end as customer_segment,
        case
            when days_since_last_order > 90 then 'Inactive'
            when days_since_last_order > 30 then 'At Risk'
            else 'Active'
        end as customer_status
    from customer_orders
)

select * from final
