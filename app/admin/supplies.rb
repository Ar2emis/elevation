# frozen_string_literal: true

ActiveAdmin.register Supply do
  permit_params :code, :weight, :grain_type_id

  actions :all, except: [:edit]

  index do
    selectable_column if current_user.administrator? || current_user.transportation_manager?
    column :code do |resource|
      link_to resource.code, resource_path(resource)
    end
    column t('supply.properties.weight'), &:weight
    column :grain_type
    actions
  end

  show do
    attributes_table do
      row :code
      row :weight do |supply|
        t('mass.tons', weight: supply.weight)
      end
      row :created_at
    end
  end

  controller do
    def create
      result = Supply::Operation::Create.call(params: params.permit!)
      @resource = result[:model]
      return render(:new) if result.failure?

      redirect_to collection_path(@resource), notice: I18n.t('admin.resource.successfully_created',
                                                             resource: resource_class.to_s.titleize)
    end

    def destroy
      result = Supply::Operation::Destroy.call(params: params.permit!)
      redirect_to collection_path(result[:model]), notice: I18n.t('admin.resource.successfully_deleted',
                                                                  resource: resource_class.to_s.titleize)
    end
  end
end
