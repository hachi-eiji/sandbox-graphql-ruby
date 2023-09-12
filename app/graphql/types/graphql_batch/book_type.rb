# frozen_string_literal: true

module Types
  module GraphqlBatch
    class BookType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :purchase_on, GraphQL::Types::ISO8601Date, null: false
      field :user, Types::GraphqlBatch::UserType, null: false

      def user
        Loaders::AssociationLoader.for(Book, :user).load(object)
      end
    end
  end
end
