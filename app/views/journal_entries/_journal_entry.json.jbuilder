json.extract! journal_entry, :id, :type, :amount, :value_date, :creation_date, :statement_id, :error, :data, :created_at, :updated_at
json.url journal_entry_url(journal_entry, format: :json)
