# frozen_string_literal: true

ActiveAdmin.register Storage do
  permit_params :name, :capacity

  index do
    selectable_column if current_user.administrator?
    column :name do |resource|
      link_to resource.name, resource_path(resource)
    end
    column(t('storage.properties.capacity'), &:capacity)
    actions
  end
end
