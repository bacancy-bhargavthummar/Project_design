class Book < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :book_sellers, dependent: :destroy
  has_one_attached :image 

  scope :searching,->(s){Book.joins(:category).where("books.book_name LIKE ? OR books.book_author LIKE ? OR books.isbn LIKE ? OR categories.category_name LIKE ? ","%#{s}%","%#{s}%","%#{s}%","%#{s}%") }
  
end