# frozen_string_literal: true

module Types
  module GraphqlRuby
    class UserType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :purchase_books, [Types::GraphqlRuby::BookType]
      field :has_book, Boolean

      def purchase_books
        dataloader.with(::Sources::BooksByUser).load(object.id)
      end

      def has_book
        today = Time.zone.today.beginning_of_day
        dataloader.with(::Sources::ExistsSource, Book, :user_id, { created_at: today.. }).load(object.id)
      end
    end
  end
end
