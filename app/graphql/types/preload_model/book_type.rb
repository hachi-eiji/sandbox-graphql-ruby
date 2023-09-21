# frozen_string_literal: true

module Types
  module PreloadModel
    class BookType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :purchase_on, GraphQL::Types::ISO8601Date, null: false
      field :user, Types::PreloadModel::UserType, null: false
    end
  end
end
