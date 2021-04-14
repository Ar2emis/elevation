# frozen_string_literal: true

class StoragePolicy < ApplicationPolicy
  def index?
    user.administrator? || user.logistics_manager?
  end

  def show?
    user.administrator? || user.logistics_manager?
  end

  def new?
    create?
  end

  def create?
    user.administrator? || user.logistics_manager?
  end

  def edit?
    update?
  end

  def update?
    user.administrator? || user.logistics_manager?
  end

  def destroy?
    user.administrator? || user.logistics_manager?
  end

  def destroy_all?
    user.administrator? || user.logistics_manager?
  end
end
