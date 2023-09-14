# frozen_string_literal: true

module Resolvers
  module GraphqlBatch
    class BooksResolver < GraphQL::Schema::Resolver
      type [Types::GraphqlBatch::BookType], null: true

      def resolve
        Book.where(user_id: [1, 2, 3, 21])
      end
    end
  end
end
