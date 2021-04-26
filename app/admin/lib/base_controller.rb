# frozen_string_literal: true

class ActiveAdmin::BaseController
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_collection

  def redirect_to_collection
    redirect_to collection_path, alert: I18n.t('admin.resource.not_found', resource: resource_class.to_s.titleize)
  end
end
