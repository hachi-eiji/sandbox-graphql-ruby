# frozen_string_literal: true

module Types
  module GraphqlBatch
    class UserType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :purchase_books, [Types::GraphqlBatch::BookType]
      field :has_book, Boolean

      def purchase_books
        Loaders::AssociationLoader.for(User, :purchase_books, { created_at: :desc }).load(object)
      end

      def has_book
        today = Time.zone.today.beginning_of_day
        Loaders::ExistsLoader.for(Book, :user_id, { created_at: today.. }).load(object.id)
      end
    end
  end
end
