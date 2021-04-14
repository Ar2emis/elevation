# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

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
        f.input :role, as: :tags, collection: User.roles.keys.map { |role| [role.humanize, role] }
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
      @resource = User::Contract::Save.new(User.new)
      return render :new unless @resource.validate(params[:user])

      @resource.save
      redirect_to collection_path(@resource), notice: I18n.t('admin.resource.successfully_created',
                                                             resource: resource_class.to_s.titleize)
    end

    def update
      @resource = User::Contract::Save.new(User.find_by(id: params[:id]))
      return render :edit unless @resource.validate(params[:user])

      @resource.save
      redirect_to collection_path(@resource), notice: I18n.t('admin.resource.successfully_updated',
                                                             resource: resource_class.to_s.titleize)
    end
  end
end
