# frozen_string_literal: true

class Lib::ApplicationContract < Reform::Form
  delegate :persisted?, to: :model
  include Dry
  include Lib::Contract::CustomPredicates

  def self.model_name
    module_parent.module_parent.model_name
  end
end
