# frozen_string_literal: true

module Transaction::Contract
  class StorageToTemporary < Lib::ApplicationContract
    property :form
    property :from
    property :amount

    def amount=(value)
      super(value.to_i)
    end

    validation do
      configure do
        config.namespace = 'transaction.storage_to_temporary'
        option :form
        predicates(Lib::Contract::CustomPredicates)
      end

      required(:from).filled
      required(:amount).filled(gt?: 0)

      rule(amount: %i[amount from]) { |amount| amount.enough_grain?(value(:from)) }
    end
  end
end
