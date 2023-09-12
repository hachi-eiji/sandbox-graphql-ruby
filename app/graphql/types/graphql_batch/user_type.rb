# frozen_string_literal: true

module Types
  module GraphqlBatch
    class UserType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :purchase_books, [Types::GraphqlBatch::BookType]

      def purchase_books
        Loaders::AssociationLoader.for(User, :purchase_books, { created_at: :desc }).load(object)
      end
    end
  end
end
