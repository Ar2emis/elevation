# frozen_string_literal: true

module Lib
  module Contract
    module CustomPredicates
      include Dry::Logic::Predicates

      predicate(:uniq?) do |klass, field, form, value|
        !klass.where.not(id: form.model.id).exists?(field => value)
      end
    end
  end
end
