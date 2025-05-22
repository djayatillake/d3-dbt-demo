with source as (
    select * from {{ ref('customers') }}
),

renamed as (
    select
        customer_id,
        first_name,
        last_name,
        email,
        city,
        state,
        country,
        created_at,
        updated_at,
        concat(first_name, ' ', last_name) as full_name
    from source
)

select * from renamed
