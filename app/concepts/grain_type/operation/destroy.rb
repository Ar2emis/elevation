# frozen_string_literal: true

module GrainType::Operation
  class Destroy < Trailblazer::Operation
    step Model(::GrainType, :find_by)
    step :temporary_storage_empty?
    fail :set_error
    step :destroy

    def temporary_storage_empty?(_ctx, model:, **)
      !model.temporary_storage.amount.positive?
    end

    def set_error(ctx, **)
      ctx[:error] = I18n.t('grain_type.errors.temporary_storage_is_not_empty')
    end

    def destroy(_ctx, model:, **)
      model.destroy
    end
  end
end
