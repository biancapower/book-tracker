FactoryBot.define do
  factory :book do
    open_library_key { "MyString" }
    title { "MyString" }
    number_of_pages { 1 }
    first_sentence { "MyText" }
    description { "MyText" }
  end
end
