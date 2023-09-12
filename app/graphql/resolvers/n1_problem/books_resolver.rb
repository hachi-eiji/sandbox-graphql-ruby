# frozen_string_literal: true

module Resolvers
  module N1Problem
    class BooksResolver < GraphQL::Schema::Resolver
      type [Types::N1Problem::BookType], null: true

      def resolve
        Book.limit(5)
      end
    end
  end
end
