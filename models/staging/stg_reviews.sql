with source as (
    select * from {{ source('olist', 'reviews') }}
),

renamed as (
    select
        review_id,
        order_id,
        
        -- Handling Score (1-5)
        cast(review_score as int64) as review_score,
        
        -- Text Content
        review_comment_title,
        review_comment_message,
        
        -- Timestamps
        cast(review_creation_date as timestamp) as created_at,
        cast(review_answer_timestamp as timestamp) as answered_at

    from source
)

select * from renamed