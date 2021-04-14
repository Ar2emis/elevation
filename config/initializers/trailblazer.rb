# frozen_string_literal: true

require 'reform/form/dry'

Dry::Validation::Schema::Form.configure do |config|
  config.messages = :i18n
end
