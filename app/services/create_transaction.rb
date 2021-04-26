# frozen_string_literal: true

class CreateTransaction
  class << self
    def call(_ctx, from:, to:, amount:, **)
      Transaction.create!(from: resource_name(from), to: resource_name(to), amount: amount, grain_type: from.grain_type)
    end

    private

    def resource_name(resource)
      entity = resource.class.to_s.titleize
      name = case resource
             when Supply then resource.code
             when Storage then resource.name
             when Export then resource.code
             else ''
             end
      entity + (name.empty? ? '' : ": #{name}")
    end
  end
end
