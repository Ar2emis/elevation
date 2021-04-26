# frozen_string_literal: true

class Storage < ApplicationRecord
  belongs_to :grain_type, optional: true
end
