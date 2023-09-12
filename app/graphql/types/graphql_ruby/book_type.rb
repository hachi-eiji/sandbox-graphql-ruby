# frozen_string_literal: true

module Types
  module GraphqlRuby
    class BookType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :purchase_on, GraphQL::Types::ISO8601Date, null: false
      field :user, Types::GraphqlRuby::UserType, null: false

      def user
        dataloader.with(::Sources::ActiveRecordObject, User).load(object.user_id)
      end
    end
  end
end
