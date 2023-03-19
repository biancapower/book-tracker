class Book < ApplicationRecord
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  accepts_nested_attributes_for :authors, allow_destroy: true

  validates :open_library_key, presence: true, uniqueness: true
  validates :title, presence: true
  validates :number_of_pages, numericality: { greater_than: 0, only_integer: true }, allow_nil: true

  def associate_authors_by_open_library_keys(open_library_keys)
    keys = process_comma_separated_values(open_library_keys)
    keys.each do |open_library_key|
      author = Author.find_or_initialize_by(open_library_key: open_library_key)
      authors << author
    end
  end

  def update_cover_images_list(cover_images)
    cover_image_ids = process_comma_separated_values(cover_images)
    update(cover_images: cover_image_ids)
  end

  private

  def process_comma_separated_values(input_string)
    input_string.gsub(/\s+/, '').split(',')
  end
end
