json.extract! post, :id, :title, :description, :publish_date, :lookup_post_type_id, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
