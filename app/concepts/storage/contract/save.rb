# frozen_string_literal: true

module Storage::Contract
  class Save < Lib::ApplicationContract
    property :name
    property :capacity
    property :fullness, readonly: true

    def capacity=(value)
      super(value.to_i)
    end

    validation do
      configure do
        config.namespace = :storage
        option :form
        predicates(Lib::Contract::CustomPredicates)
      end

      required(:name).filled
      required(:capacity).filled
      required(:fullness).filled

      rule(name: [:name]) { |name| name.filled? > name.uniq?(Storage, :name, form) }
      rule(capacity: [:capacity]) { |capacity| capacity.gt?(0) }
      rule(capacity: [:capacity]) { |capacity| capacity.gt?(0) > capacity.gt_or_eql_fullness?(value(:fullness)) }
    end
  end
end
