# frozen_string_literal: true

class ActiveAdmin::PagePolicy < ApplicationPolicy
  def index?
    true
  end
end
