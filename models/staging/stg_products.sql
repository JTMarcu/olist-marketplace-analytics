with products as (
    select * from {{ source('olist', 'products') }}
),

translations as (
    select 
        -- Manually map the "dirty" generic columns to clean names
        string_field_0 as product_category_name,
        string_field_1 as product_category_name_english
    
    from {{ source('olist', 'product_category_name_translation') }}
    
    -- Filter out the row that contains the headers since the first row has 'product_category_name', 'product_category_name_english'
    where string_field_0 != 'product_category_name' 
),

final as (
    select
        p.product_id,
        
        -- Logic: If we find a translation, use it. Otherwise fall back to Portuguese.
        coalesce(t.product_category_name_english, p.product_category_name, 'Unknown') as product_category,
        
        -- Product Dimensions (Standardizing typos)
        cast(p.product_name_lenght as int64) as name_length,
        cast(p.product_description_lenght as int64) as description_length,
        cast(p.product_photos_qty as int64) as photos_qty,
        cast(p.product_weight_g as int64) as weight_g,
        cast(p.product_length_cm as int64) as length_cm,
        cast(p.product_height_cm as int64) as height_cm,
        cast(p.product_width_cm as int64) as width_cm

    from products p
    left join translations t
        on p.product_category_name = t.product_category_name
)

select * from final