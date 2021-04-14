# frozen_string_literal: true

module Admin
  module Formable
    module All
      def self.extended(base)
        base.instance_eval do
          extend Admin::Formable::Create
          extend Admin::Formable::Update
        end
      end
    end

    module Create
      def self.extended(base) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        base.instance_eval do
          actions :all, except: [:create]

          collection_action :create, method: :post do
            authorize(resource_class)

            result = resource_class.name.pluralize.constantize::Operation::Create.call(params: params)
            @resource = Formable.resource(result)

            if result.success?
              redirect_to collection_path, notice: (result[:success_message] ||
                Formable.flash_message(params, resource_class))
            else
              render 'new'
            end
          end
        end
      end
    end

    module Update
      def self.extended(base) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        base.instance_eval do
          actions :all, except: [:update]

          member_action :update, method: :put do
            authorize(resource)

            result = resource_class.name.pluralize.constantize::Operation::Update.call(params: params)
            @resource = Formable.resource(result)

            if result.success?
              redirect_to collection_path, notice: (result[:success_message] ||
                Formable.flash_message(params, resource_class))
            else
              render 'edit'
            end
          end
        end
      end
    end

    class << self
      def resource(result)
        result[:model].errors.present? ? result[:model] : result['contract.default']
      end

      def flash_message(params, resource_class)
        I18n.t("flash.actions.#{params[:action]}", model: resource_class.name.titleize)
      end
    end
  end
end
