# frozen_string_literal: true

module Export::Operation
  class Destroy < Trailblazer::Operation
    step Model(::Export, :find_by)
    step :temporary_storage
    step :amount
    step ChangeTemporaryStorageAmount
    step :from
    step :to
    step CreateTransaction
    step :destroy

    def temporary_storage(ctx, model:, **)
      ctx[:temporary_storage] = model.grain_type.temporary_storage
    end

    def amount(ctx, model:, **)
      ctx[:amount] = model.amount
    end

    def from(ctx, model:, **)
      ctx[:from] = model
    end

    def to(ctx, model:, **)
      ctx[:to] = model.grain_type.temporary_storage
    end

    def destroy(_ctx, model:, **)
      model.destroy
    end
  end
end
