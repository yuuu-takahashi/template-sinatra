# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    email { 'john.doe@example.com' }
  end

  initialize_with { new(attributes.stringify_keys) }
end
