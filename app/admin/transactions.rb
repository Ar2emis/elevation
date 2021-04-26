# frozen_string_literal: true

ActiveAdmin.register Transaction do
  permit_params :amount, :from, :to, :form
  actions :index, :show, :new, :create

  config.clear_action_items!

  index do
    render partial: 'temporary_storages/statistics'

    index_column
    column :from
    column :to
    column t('transaction.properties.amount'), &:amount
    column :grain_type

    actions
  end

  storage_to_storage_form = lambda do |context, f, select_collection|
    f.input :from, collection: select_collection
    f.input :to, collection: select_collection
    f.input :amount, label: context.t('transaction.properties.amount'), as: :number
  end

  temporary_to_storage_form = lambda do |context, f, select_collection|
    f.input :to, collection: select_collection
    f.input :grain_type, required: false
    f.input :amount, label: context.t('transaction.properties.amount'), as: :number
  end

  storage_to_temporary_form = lambda do |context, f, select_collection|
    f.input :from, collection: select_collection
    f.input :amount, label: context.t('transaction.properties.amount'), as: :number
  end

  form title: proc { t("transaction.form.#{params.dig(:transaction, :form)}") } do |f|
    f.inputs do
      f.input :form, default: params.dig(:transaction, :form), as: :hidden
      select_collection = Storage.all
      form = case params.dig(:transaction, :form).to_sym
             when :storage_storage then storage_to_storage_form
             when :temporary_to_storage then temporary_to_storage_form
             when :storage_to_temporary then storage_to_temporary_form
             end
      form.call(self, f, select_collection)
    end

    f.actions
  end

  action_item :storage_storage, only: :index do
    link_to t('transaction.form.storage_storage'),
            new_transaction_path(transaction: { form: :storage_storage })
  end

  action_item :temporary_to_storage, only: :index do
    link_to t('transaction.form.temporary_to_storage'),
            new_transaction_path(transaction: { form: :temporary_to_storage })
  end

  action_item :storage_to_temporary, only: :index do
    link_to t('transaction.form.storage_to_temporary'),
            new_transaction_path(transaction: { form: :storage_to_temporary })
  end

  controller do
    def create
      result = operation.call(params: params.permit!)
      @resource = result[:model]
      return render(:new) if result.failure?

      redirect_to collection_path(@resource), notice: I18n.t('admin.resource.successfully_created',
                                                             resource: resource_class.to_s.titleize)
    end

    private

    def operation
      case params.dig(:transaction, :form).to_sym
      when :storage_storage then Transaction::Operation::StorageToStorage
      when :temporary_to_storage then Transaction::Operation::TemporaryToStorage
      when :storage_to_temporary then Transaction::Operation::StorageToTemporary
      end
    end
  end
end
