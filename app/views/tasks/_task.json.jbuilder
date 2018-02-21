json.extract! task, :id, :description, :type, :done, :last_completed, :next_refresh, :created_at, :updated_at
json.url task_url(task, format: :json)
