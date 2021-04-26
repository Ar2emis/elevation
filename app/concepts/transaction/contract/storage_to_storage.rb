# frozen_string_literal: true

module Transaction::Contract
  class StorageToStorage < Lib::ApplicationContract
    property :form
    property :from
    property :to
    property :amount

    def amount=(value)
      super(value.to_i)
    end

    validation do
      configure do
        config.namespace = 'transaction.storage_to_storage'
        option :form
        predicates(Lib::Contract::CustomPredicates)
      end

      required(:from).filled
      required(:to).filled
      required(:amount).filled(gt?: 0)

      rule(from: %i[from to]) { |from| from.not_eql?(value(:to)) }
      rule(from: %i[from to]) { |from| from.same_grain_type?(value(:to)) }
      rule(amount: %i[amount from to]) { |amount| amount.enough_grain?(value(:from)) }
      rule(amount: %i[amount from to]) { |amount| amount.enough_space?(value(:to)) }
    end
  end
end
