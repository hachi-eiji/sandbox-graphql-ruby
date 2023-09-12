# frozen_string_literal: true

module Sources
  class BooksByUser < GraphQL::Dataloader::Source
    def initialize
      @model = Book
    end

    def fetch(keys)
      records = @model.where(user_id: keys).order(:purchase_on).group_by(&:user_id)
      keys.map { |key| records[key] || [] }
    end
  end
end
