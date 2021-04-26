# frozen_string_literal: true

ActiveAdmin.register TemporaryStorage do
  permit_params :amount, :grain_type_id

  index do
    selectable_column
    index_column
    column :amount
    column :grain_type

    actions
  end
end
