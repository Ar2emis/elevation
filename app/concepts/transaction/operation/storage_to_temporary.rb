# frozen_string_literal: true

module Transaction::Operation
  class StorageToTemporary < Trailblazer::Operation
    step Model(::Transaction, :new)
    step Contract::Build(constant: Transaction::Contract::StorageToTemporary)
    step Contract::Validate(key: :transaction)
    fail SyncErrors
    step :from
    step :to
    step :amount
    step :grain_type
    step :transfer
    step CreateTransaction
    step :synchronize_storage

    def from(ctx, **)
      ctx[:from] = Storage.find_by(id: ctx['contract.default'].from)
    end

    def to(ctx, from:, **)
      ctx[:to] = from.grain_type.temporary_storage
    end

    def amount(ctx, **)
      ctx[:amount] = ctx['contract.default'].amount
    end

    def grain_type(ctx, from:, **)
      ctx[:grain_type] = from.grain_type
    end

    def transfer(_ctx, from:, to:, amount:, **)
      from.update(fullness: from.fullness - amount)
      to.update(amount: to.amount + amount)
    end

    def synchronize_storage(_ctx, from:, grain_type:, **)
      Storage::Operation::Synchronize.call(storage: from, grain_type: grain_type)
    end
  end
end
