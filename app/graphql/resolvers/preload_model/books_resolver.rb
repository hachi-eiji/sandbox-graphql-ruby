# frozen_string_literal: true

module Resolvers
  module PreloadModel
    class BooksResolver < GraphQL::Schema::Resolver
      type [Types::PreloadModel::BookType], null: true

      def resolve
        Book.preload(:user).limit(5)
      end
    end
  end
end
