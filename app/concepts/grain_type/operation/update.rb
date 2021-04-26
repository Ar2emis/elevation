# frozen_string_literal: true

module GrainType::Operation
  class Update < Trailblazer::Operation
    step Model(::GrainType, :find_by)
    step Contract::Build(constant: GrainType::Contract::Save)
    step Contract::Validate(key: :grain_type)
    fail SyncErrors
    step Contract::Persist()
  end
end
