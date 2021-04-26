# frozen_string_literal: true

module Supply::Operation
  class Create < Trailblazer::Operation
    step Model(::Supply, :new)
    step Contract::Build(constant: Supply::Contract::Create)
    step Contract::Validate(key: :supply)
    fail SyncErrors
    step Contract::Persist()
    step :temporary_storage
    step :amount
    step ChangeTemporaryStorageAmount
    step :from
    step :to
    step CreateTransaction

    def temporary_storage(ctx, model:, **)
      ctx[:temporary_storage] = model.grain_type.temporary_storage
    end

    def amount(ctx, model:, **)
      ctx[:amount] = model.weight
    end

    def from(ctx, model:, **)
      ctx[:from] = model
    end

    def to(ctx, model:, **)
      ctx[:to] = model.grain_type.temporary_storage
    end
  end
end
