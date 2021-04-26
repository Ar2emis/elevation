# frozen_string_literal: true

module Storage::Operation
  class Update < Trailblazer::Operation
    step Model(::Storage, :find_by)
    step Contract::Build(constant: Storage::Contract::Save)
    step Contract::Validate(key: :storage)
    fail SyncErrors
    step Contract::Persist()
  end
end
