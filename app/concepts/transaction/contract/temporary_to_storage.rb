# frozen_string_literal: true

module Transaction::Contract
  class TemporaryToStorage < Lib::ApplicationContract
    property :form
    property :grain_type_id
    property :to
    property :amount

    def amount=(value)
      super(value.to_i)
    end

    validation do
      configure do
        config.namespace = 'transaction.temporary_to_storage'
        option :form
        predicates(Lib::Contract::CustomPredicates)
      end

      required(:to).filled
      required(:grain_type_id).filled
      required(:amount).filled(gt?: 0)

      rule(grain_type: %i[to grain_type_id]) { |to| to.can_be_filled_with?(value(:grain_type_id)) }
      rule(amount: %i[amount grain_type_id]) { |amount| amount.enough_grain_in_temporary?(value(:grain_type_id)) }
      rule(amount: %i[amount to]) { |amount| amount.enough_space?(value(:to)) }
    end
  end
end
