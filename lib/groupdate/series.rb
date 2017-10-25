module Groupdate
  class Series
    attr_accessor :magic, :relation

    def initialize(magic, relation)
      @magic = magic
      @relation = relation
    end

    # clone to prevent modifying original variables
    def method_missing(method, *args, &block)
      if relation.respond_to?(method, true)
        magic.perform(relation, method, *args, &block)
      else
        super
      end
    end

    def respond_to?(method, include_all = false)
      relation.respond_to?(method) || super
    end

    def order_values
      relation.order_values
    end

    def group_values
      relation.group_values
    end

    def order(value)
      magic.process_order(value)
      self
    end

    def reorder(value)
      magic.process_order(value)
      self
    end

    def reverse_order
      magic.reverse_order
      self
    end
  end
end
