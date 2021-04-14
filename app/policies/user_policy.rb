# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.administrator? || record.id == user.id
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
    user.administrator? || record.id == user.id
  end

  def destroy?
    user.administrator?
  end

  def destroy_all?
    user.administrator?
  end
end
