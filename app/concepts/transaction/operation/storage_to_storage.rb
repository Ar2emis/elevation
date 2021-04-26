# frozen_string_literal: true

module Transaction::Operation
  class StorageToStorage < Trailblazer::Operation
    step Model(::Transaction, :new)
    step Contract::Build(constant: Transaction::Contract::StorageToStorage)
    step Contract::Validate(key: :transaction)
    fail SyncErrors
    step :from
    step :to
    step :amount
    step :grain_type
    step :transfer
    step CreateTransaction
    step :synchronize_storages

    def from(ctx, **)
      ctx[:from] = Storage.find_by(id: ctx['contract.default'].from)
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
      from.update(fullness: from.fullness - amount)
      to.update(fullness: to.fullness + amount)
    end

    def synchronize_storages(_ctx, from:, to:, grain_type:, **)
      [from, to].each { |storage| Storage::Operation::Synchronize.call(storage: storage, grain_type: grain_type) }
    end
  end
end
