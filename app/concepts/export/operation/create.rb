# frozen_string_literal: true

module Export::Operation
  class Create < Trailblazer::Operation
    step Model(::Export, :new)
    step Contract::Build(constant: Export::Contract::Create)
    step Contract::Validate(key: :export)
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
      ctx[:amount] = -model.amount
    end

    def from(ctx, model:, **)
      ctx[:from] = model.grain_type.temporary_storage
    end


    def transaction_amount(ctx, model:, **)
      ctx[:amount] = model.amount
    end

    def to(ctx, model:, **)
      ctx[:to] = model
    end
  end
end
