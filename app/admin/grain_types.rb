# frozen_string_literal: true

ActiveAdmin.register GrainType do
  permit_params :name

  index do
    selectable_column if current_user.administrator?
    column :name do |resource|
      link_to resource.name, resource_path(resource)
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  controller do
    def create
      result = GrainType::Operation::Create.call(params: params.permit!)
      @resource = result[:model]
      return render(:new) if result.failure?

      redirect_to collection_path(@resource), notice: I18n.t('admin.resource.successfully_created',
                                                             resource: resource_class.to_s.titleize)
    end

    def update
      result = GrainType::Operation::Update.call(params: params.permit!)
      @resource = result[:model]
      return render(:edit) if result.failure?

      redirect_to collection_path(@resource), notice: I18n.t('admin.resource.successfully_updated',
                                                             resource: resource_class.to_s.titleize)
    end

    def destroy
      result = GrainType::Operation::Destroy.call(params: params.permit!)
      return redirect_back(fallback_location: collection_path, alert: result[:error]) if result.failure?

      redirect_to(collection_path, notice: I18n.t('admin.resource.successfully_destroyed',
                                                  resource: resource_class.to_s.titleize))
    end
  end
end
