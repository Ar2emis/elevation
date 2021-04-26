# frozen_string_literal: true

ActiveAdmin.register_page I18n.t('active_admin.dashboard') do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      render partial: 'test_chart'
    end
  end
end
