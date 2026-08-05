json.extract! book, :id, :title, :memo, :created_at, :updated_at
json.url book_url(book, format: :json)

json.extract! report, :id, :name, :content, :created_at, :updated_at
json.url report_url(report, format: :json)
