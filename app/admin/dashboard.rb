# frozen_string_literal: true

ActiveAdmin.register_page I18n.t('active_admin.dashboard') do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'row' do
      div class: 'w-33 center' do
        h2 'Most imported'
        div { column_chart Supply.joins(:grain_type).group('grain_types.name').sum(:weight) }
      end
      div class: 'w-33 center' do
        h2 'Current Fullness'
        div { pie_chart Storage.joins(:grain_type).group('grain_types.name').sum(:fullness) }
      end
      div class: 'w-33 center' do
        h2 'Most exported'
        div { column_chart Export.joins(:grain_type).group('grain_types.name').sum(:amount) }
      end
    end
    div do
      h2 'Most used transactions'
      div { bar_chart Transaction.group("concat(split_part(\"from\", ':', 1), ' -> ', split_part(\"to\", ':', 1))").count }
    end
    div do
      h2 'Import/Export Timeline'
      div do
        line_chart [
          { name: 'Export', data: Export.group("DATE_TRUNC('day', created_at)").count },
          { name: 'Import', data: Supply.group("DATE_TRUNC('day', created_at)").count }
        ]
      end
    end
  end
end
