# frozen_string_literal: true

module Types
  module PreloadModel
    class UserType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :purchase_books, [Types::PreloadModel::BookType]
    end
  end
end
