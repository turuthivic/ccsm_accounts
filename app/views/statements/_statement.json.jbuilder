json.extract! statement, :id, :name, :start_date, :end_date, :user_id, :extracted_data, :statement, :uploaded_at, :uploaded_by, :data, :error, :created_at, :updated_at
json.url statement_url(statement, format: :json)
json.statement url_for(statement.statement)
