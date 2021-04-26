# frozen_string_literal: true

class ChangeTemporaryStorageAmount
  def self.call(_ctx, temporary_storage:, amount:, **)
    temporary_storage.update(amount: temporary_storage.amount + amount)
  end
end
