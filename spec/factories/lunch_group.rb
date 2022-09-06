# frozen_string_literal: true

FactoryBot.define do
  factory :lunch_group do
    user_id { association(:user) }
    group_id { association(:group) }
  end
end
