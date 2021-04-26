# frozen_string_literal: true

module Storage::Operation
  class Create < Trailblazer::Operation
    step Model(::Storage, :new)
    step Contract::Build(constant: Storage::Contract::Save)
    step Contract::Validate(key: :storage)
    fail SyncErrors
    step Contract::Persist()
  end
end
