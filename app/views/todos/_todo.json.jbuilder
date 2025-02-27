json.extract! todo, :id, :title, :description, :order_priority, :created_at, :updated_at
json.url todo_url(todo, format: :json)
