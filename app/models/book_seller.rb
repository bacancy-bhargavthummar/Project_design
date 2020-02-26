class BookSeller < ApplicationRecord
  belongs_to :book
  belongs_to :seller, class_name: 'User'
end
