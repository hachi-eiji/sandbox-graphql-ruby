# frozen_string_literal: true

module Loaders
  class ExistsLoader < GraphQL::Batch::Loader
    def initialize(model, group_column, conditions = {})
      super()
      @model = model
      @group_name = group_column
      @conditions = conditions
    end

    def perform(keys)
      condition = {}
      condition[@group_name] = keys
      condition = condition.merge(@conditions)

      # conditionにTime.currentを渡した場合グループ化のキャッシュキーの一部となるため
      # N+1ループが回るので注意
      # Time.zone.today,Time.zone.today.beginning_of_dayは大丈夫
      # https://github.com/Shopify/graphql-batch/issues/161
      values = @model.where(condition).group(@group_name).pluck(@group_name).to_set
      keys.each do |key|
        fulfill(key, values.include?(key))
      end
    end
  end
end
