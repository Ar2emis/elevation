# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :name, :role, :password, :password_confirmation

  index do
    selectable_column if current_user.administrator?
    column :email
    column :name
    tag_column :role
    actions
  end

  filter :email
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      if current_user.administrator?
        f.input :role, as: :select, collection: User.roles.keys.map { |role| [role.humanize, role] }
      end
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :name
      tag_row :role
    end
  end

  controller do
    def create
      result = User::Operation::Create.call(params: params.permit!)
      @resource = result[:model]
      return render(:new) if result.failure?

      redirect_to collection_path(@resource), notice: I18n.t('admin.resource.successfully_created',
                                                             resource: resource_class.to_s.titleize)
    end

    def update
      result = User::Operation::Update.call(params: params.permit!)
      @resource = result[:model]
      return render(:new) if result.failure?

      redirect_to collection_path(@resource), notice: I18n.t('admin.resource.successfully_updated',
                                                             resource: resource_class.to_s.titleize)
    end
  end
end
