# frozen_string_literal: true

module Export::Contract
  class Create < Lib::ApplicationContract
    property :code
    property :amount
    property :grain_type_id

    def amount=(value)
      super(value.to_i)
    end

    validation do
      configure do
        config.namespace = :export
        option :form
        predicates(Lib::Contract::CustomPredicates)
      end

      required(:code).filled
      required(:amount).filled(gt?: 0)
      required(:grain_type_id).filled

      rule(amount: %i[amount grain_type_id]) { |amount| amount.enough_grain_in_temporary?(value(:grain_type_id)) }
    end
  end
end
