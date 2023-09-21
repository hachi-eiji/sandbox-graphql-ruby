# frozen_string_literal: true

module Sources
  class ExistsSource < GraphQL::Dataloader::Source
    def initialize(model, group_name, conditions)
      @model = model
      @group_name = group_name
      @conditions = conditions
    end

    def fetch(keys)
      condition = {}
      condition[@group_name] = keys
      condition = condition.merge(@conditions)
      records = @model.where(condition).group(@group_name).pluck(@group_name).to_set
      keys.map { |key| records.include?(key) }
    end
  end
end
