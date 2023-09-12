# frozen_string_literal: true

module Resolvers
  module GraphqlBatch
    class BooksResolver < GraphQL::Schema::Resolver
      type [Types::GraphqlBatch::BookType], null: true

      def resolve
        Book.limit(5)
      end
    end
  end
end
