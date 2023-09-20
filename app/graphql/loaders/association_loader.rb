# frozen_string_literal: true

# https://github.com/Shopify/graphql-batch/blob/3b22366f718d43ca2ed8725d0213f92b84752562/examples/association_loader.rb
module Loaders
  class AssociationLoader < GraphQL::Batch::Loader
    def self.validate(model, association_name)
      new(model, association_name)
      nil
    end

    def initialize(model, association_name, where: nil, orders: nil, scope_names: nil)
      super()
      @model = model
      @association_name = association_name
      @where = where
      @orders = orders
      @scope_names = scope_names
      validate
    end

    def load(record)
      raise TypeError, "#{@model} loaders can't load association for #{record.class}" unless record.is_a?(@model)
      return Promise.resolve(read_association(record)) if association_loaded?(record)
      super
    end

    # We want to load the associations on all records, even if they have the same id
    def cache_key(record)
      record.object_id
    end

    def perform(records)
      preload_association(records)
      records.each { |record| fulfill(record, read_association(record)) }
    end

    private

    def validate
      unless @model.reflect_on_association(@association_name)
        raise ArgumentError, "No association #{@association_name} on #{@model}"
      end
    end

    def preload_association(records)
      ::ActiveRecord::Associations::Preloader.new(
        records: records,
        associations: @association_name,
        scope: create_reflect_association).call
    end

    def read_association(record)
      record.public_send(@association_name)
    end

    def association_loaded?(record)
      record.association(@association_name).loaded?
    end

    # 参考部分とここがちがう
    def create_reflect_association
      reflect_association = nil
      if @where.present? || @orders.present? || @scope_names.present?
        reflect_association = @model.reflect_on_association(@association_name).klass

        reflect_association = reflect_association.where(@where) if @where.present?
        reflect_association = reflect_association.order(@orders) if @orders.present?

        [@scope_names].flatten.compact.each do |scope|
          reflect_association = reflect_association.send(scope)
        end
      end
      reflect_association
    end
  end
end
