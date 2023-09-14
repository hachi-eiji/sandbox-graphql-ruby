# frozen_string_literal: true

module Loaders
  class ExistsLoader < GraphQL::Batch::Loader
    def initialize(model, group_column)
      super()
      @model = model
      @group_name = group_column
    end

    def perform(keys)
      condition = {}
      condition[@group_name] = keys
      values = @model.where(condition).group(@group_name).pluck(@group_name).to_set
      keys.each do |key|
        fulfill(key, values.include?(key))
      end
    end
  end
end
