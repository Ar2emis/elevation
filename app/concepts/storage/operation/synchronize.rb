# frozen_string_literal: true

module Storage::Operation
  class Synchronize < Trailblazer::Operation
    step :update_grain_type

    def update_grain_type(ctx, storage:, **)
      storage.update(grain_type: storage.fullness.zero? ? nil : ctx[:grain_type])
    end
  end
end
