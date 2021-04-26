# frozen_string_literal: true

class ExportPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.administrator? || user.transportation_manager?
  end

  def new?
    create?
  end

  def create?
    user.administrator? || user.transportation_manager?
  end

  def destroy?
    user.administrator? || user.transportation_manager?
  end

  def destroy_all?
    user.administrator? || user.transportation_manager?
  end
end
