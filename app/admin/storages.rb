# frozen_string_literal: true

ActiveAdmin.register Storage do
  permit_params :name, :capacity

  index do
    selectable_column if current_user.administrator?
    column :name do |resource|
      link_to resource.name, resource_path(resource)
    end
    column t('storage.properties.fullness') do |storage|
      number_to_percentage(storage.fullness.to_f / storage.capacity * 100, precision: 2)
    end
    column :grain_type
    column t('storage.properties.capacity'), &:capacity
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :capacity
    end
    f.actions
  end

  controller do
    def create
      result = Storage::Operation::Create.call(params: params.permit!)
      @resource = result[:model]
      return render(:new) if result.failure?

      redirect_to collection_path(@resource), notice: I18n.t('admin.resource.successfully_created',
                                                             resource: resource_class.to_s.titleize)
    end

    def update
      result = Storage::Operation::Update.call(params: params.permit!)
      @resource = result[:model]
      return render(:edit) if result.failure?

      redirect_to collection_path(@resource), notice: I18n.t('admin.resource.successfully_updated',
                                                             resource: resource_class.to_s.titleize)
    end
  end
end
