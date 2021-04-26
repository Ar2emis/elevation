# frozen_string_literal: true

module Lib::Contract
  module CustomPredicates
    include Dry::Logic::Predicates

    predicate(:uniq?) { |klass, field, form, value| !klass.where.not(id: form.model.id).exists?(field => value) }
    predicate(:gt_or_eql_fullness?) { |fullness, capacity| capacity >= fullness }
    predicate(:not_eql?) { |first_value, second_value| first_value != second_value }
    predicate(:enough_grain?) { |storage_id, amount| Storage.find_by(id: storage_id).fullness >= amount }

    predicate(:can_be_filled_with?) do |grain_type_id, storage_id|
      storage_grain_type_id = Storage.find_by(id: storage_id).grain_type_id
      storage_grain_type_id.blank? || storage_grain_type_id == grain_type_id.to_i
    end

    predicate(:enough_grain_in_temporary?) do |grain_type_id, amount|
      TemporaryStorage.find_by(grain_type_id: grain_type_id).amount >= amount
    end

    predicate(:same_grain_type?) do |to_id, from_id|
      to_grain_type_id = Storage.find_by(id: to_id).grain_type_id
      from_grain_type_id = Storage.find_by(id: from_id).grain_type_id
      to_grain_type_id.blank? || from_grain_type_id.blank? || to_grain_type_id == from_grain_type_id
    end

    predicate(:enough_space?) do |storage_id, amount|
      storage = Storage.find_by(id: storage_id)
      storage.fullness + amount <= storage.capacity
    end
  end
end
