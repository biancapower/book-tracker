json.extract! book, :id, :open_library_key, :title, :number_of_pages, :first_sentence, :description, :created_at, :updated_at
json.url book_url(book, format: :json)
