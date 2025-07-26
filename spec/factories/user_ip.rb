FactoryBot.define do
  factory :user_ip do
    sequence(:ip_address) { |n| "192.168.0.#{n}" }
  end
end
