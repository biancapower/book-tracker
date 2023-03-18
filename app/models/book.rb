class Book < ApplicationRecord
  has_many :author_books
  has_many :authors, through: :author_books

  validates :open_library_key, presence: true, uniqueness: true
  validates :title, presence: true
  validates :number_of_pages, numericality: { greater_than: 0, only_integer: true }, allow_nil: true
end
