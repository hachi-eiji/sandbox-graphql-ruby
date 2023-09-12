class User < ApplicationRecord
  # has_manyでスコープを指定するのはよくないです
  has_many :purchase_books, -> { order(:purchase_on) }, class_name: 'Book'
  has_many :books
end
