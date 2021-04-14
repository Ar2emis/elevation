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
      @resource = GrainType::Contract::Save.new(GrainType.new)
      return render :new unless @resource.validate(params[:grain_type])

      @resource.save
      redirect_to collection_path(@resource), notice: I18n.t('admin.resource.successfully_created',
                                                             resource: resource_class.to_s.titleize)
    end

    def update
      @resource = GrainType::Contract::Save.new(GrainType.find_by(id: params[:id]))
      return render :edit unless @resource.validate(params[:grain_type])

      @resource.save
      redirect_to collection_path(@resource), notice: I18n.t('admin.resource.successfully_updated',
                                                             resource: resource_class.to_s.titleize)
    end
  end
end
