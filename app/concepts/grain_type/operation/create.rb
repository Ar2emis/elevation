# frozen_string_literal: true

module GrainType::Operation
  class Create < Trailblazer::Operation
    step Model(::GrainType, :new)
    step Contract::Build(constant: GrainType::Contract::Save)
    step Contract::Validate(key: :grain_type)
    fail SyncErrors
    step Contract::Persist()
    step :temporary_storage

    def temporary_storage(_ctx, model:, **)
      TemporaryStorage.create(grain_type: model)
    end
  end
end
