# frozen_string_literal: true

# https://github.com/Shopify/graphql-batch/blob/3b22366f718d43ca2ed8725d0213f92b84752562/examples/record_loader.rb
module Loaders
  class RecordLoader < GraphQL::Batch::Loader
    def initialize(model, column: model.primary_key, where: nil)
      super()
      @model = model
      @column = column.to_s
      @column_type = model.type_for_attribute(@column)
      @where = where
    end

    def load(key)
      super(@column_type.cast(key))
    end

    def perform(keys)
      query(keys).each { |record| fulfill(record.public_send(@column), record) }
      keys.each { |key| fulfill(key, nil) unless fulfilled?(key) }
    end

    private

    def query(keys)
      scope = @model
      scope = scope.where(@where) if @where
      scope.where(@column => keys)
    end
  end
end
