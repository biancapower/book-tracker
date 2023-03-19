class Author < ApplicationRecord
  has_many :author_books
  has_many :books, through: :author_books

  validates :open_library_key, presence: true, uniqueness: true
  # validates :name, presence: true # make this nullable until author info is pulled from API
end
