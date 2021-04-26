# frozen_string_literal: true

module User::Contract
  class Create < Lib::ApplicationContract
    property :email
    property :name
    property :role
    property :password
    property :password_confirmation

    validation do
      configure do
        config.namespace = :user
        option :form
        predicates(Lib::Contract::CustomPredicates)
      end

      required(:email).filled
      required(:name).filled
      required(:role).filled
      required(:password).filled
      required(:password_confirmation).filled

      rule(email: [:email]) { |email| email.filled? > email.uniq?(User, :email, form) }
      rule(password_confirmation: %i[password password_confirmation]) do |password, password_confirmation|
        password.filled? & password_confirmation.filled? > password_confirmation.eql?(password)
      end
    end
  end
end
