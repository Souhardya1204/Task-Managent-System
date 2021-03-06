# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "Harry Potter" }
    email { "harry@example.com" }
    password { "password" }
  end
end
