# frozen_string_literal: true

module Resolvers
  module GraphqlRuby
    class BooksResolver < GraphQL::Schema::Resolver
      type [Types::GraphqlRuby::BookType], null: true

      def resolve
        Book.limit(5)
      end
    end
  end
end
