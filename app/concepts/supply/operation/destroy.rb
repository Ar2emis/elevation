# frozen_string_literal: true

module Supply::Operation
  class Destroy < Trailblazer::Operation
    step Model(::Supply, :find_by)
    step :temporary_storage
    step :amount
    step ChangeTemporaryStorageAmount
    step :from
    step :to
    step :transaction_amount
    step CreateTransaction
    step :destroy

    def temporary_storage(ctx, model:, **)
      ctx[:temporary_storage] = model.grain_type.temporary_storage
    end

    def amount(ctx, model:, **)
      ctx[:amount] = -model.weight
    end

    def from(ctx, model:, **)
      ctx[:from] = model.grain_type.temporary_storage
    end

    def to(ctx, model:, **)
      ctx[:to] = model
    end

    def transaction_amount(ctx, model:, **)
      ctx[:amount] = model.weight
    end

    def destroy(_ctx, model:, **)
      model.destroy
    end
  end
end
