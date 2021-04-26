# frozen_string_literal: true

class Transaction < ApplicationRecord
  attr_accessor :form

  belongs_to :grain_type
end
