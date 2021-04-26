# frozen_string_literal: true

module GrainType::Contract
  class Save < Lib::ApplicationContract
    property :name

    validation do
      configure do
        option :form
        predicates(Lib::Contract::CustomPredicates)
      end

      required(:name).filled

      rule(name: [:name]) { |name| name.filled? > name.uniq?(GrainType, :name, form) }
    end
  end
end
