# frozen_string_literal: true

class GrainType < ApplicationRecord
  has_one :temporary_storage, dependent: :destroy
end
