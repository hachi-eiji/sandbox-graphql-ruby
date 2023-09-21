# frozen_string_literal: true

module Types
  module N1Problem
    class UserType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :purchase_books, [Types::N1Problem::BookType]
      field :has_book, Boolean, method: :has_book?
    end
  end
end
