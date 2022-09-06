# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { '12345678' }
    department_id { association(:department) }
  end
end
