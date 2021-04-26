# frozen_string_literal: true

class TransactionPolicy < ApplicationPolicy
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
end
