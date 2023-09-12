# frozen_string_literal: true

module Types
  module GraphqlRuby
    class UserType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :purchase_books, [Types::GraphqlRuby::BookType]

      def purchase_books
        dataloader.with(::Sources::BooksByUser).load(object.id)
      end
    end
  end
end
