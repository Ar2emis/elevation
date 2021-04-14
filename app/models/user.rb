# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable

  enum role: { administrator: 0, logistics_manager: 1, transportation_manager: 2 }
end
