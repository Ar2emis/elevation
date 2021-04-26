# frozen_string_literal: true

module Supply::Contract
  class Create < Lib::ApplicationContract
    property :code
    property :weight
    property :grain_type_id

    def weight=(value)
      super(value.to_i)
    end

    validation do
      required(:code).filled
      required(:weight).filled(gt?: 0)
      required(:grain_type_id).filled
    end
  end
end
