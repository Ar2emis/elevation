# frozen_string_literal: true

module User::Operation
  class Update < Trailblazer::Operation
    step Model(::User, :find_by)
    step Contract::Build(constant: User::Contract::Update)
    step Contract::Validate(key: :user)
    fail SyncErrors
    step Contract::Persist()
  end
end
