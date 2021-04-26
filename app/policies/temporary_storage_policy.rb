# frozen_string_literal: true

class TemporaryStoragePolicy < ApplicationPolicy
  def index?
    user.administrator?
  end

  def show?
    user.administrator?
  end

  def new?
    create?
  end

  def create?
    user.administrator?
  end

  def edit?
    update?
  end

  def update?
    user.administrator?
  end

  def destroy?
    user.administrator?
  end

  def destroy_all?
    user.administrator?
  end
end
