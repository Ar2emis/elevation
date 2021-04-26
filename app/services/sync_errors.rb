# frozen_string_literal: true

class SyncErrors
  def self.call(ctx, model:, **)
    form = ctx['contract.default']
    form.sync
    form.errors.messages.each do |property, messages|
      messages.each { |message| model.errors.add(property, message) }
    end
  end
end
