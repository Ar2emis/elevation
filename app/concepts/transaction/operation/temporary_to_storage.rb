# frozen_string_literal: true

module Transaction::Operation
  class TemporaryToStorage < Trailblazer::Operation
    step Model(::Transaction, :new)
    step Contract::Build(constant: Transaction::Contract::TemporaryToStorage)
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
      ctx[:from] = TemporaryStorage.find_by(grain_type_id: ctx['contract.default'].grain_type_id)
    end

    def to(ctx, **)
      ctx[:to] = Storage.find_by(id: ctx['contract.default'].to)
    end

    def amount(ctx, **)
      ctx[:amount] = ctx['contract.default'].amount
    end

    def grain_type(ctx, from:, **)
      ctx[:grain_type] = from.grain_type
    end

    def transfer(_ctx, from:, to:, amount:, **)
      from.update(amount: from.amount - amount)
      to.update(fullness: to.fullness + amount)
    end

    def synchronize_storage(_ctx, to:, grain_type:, **)
      Storage::Operation::Synchronize.call(storage: to, grain_type: grain_type)
    end
  end
end
