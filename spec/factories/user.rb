FactoryGirl.define do
  factory :user, class: User do
    name 'User'
    zip_code '79000'
    city 'City'
    address 'Address'
    sequence(:email) { |n| "email_#{n}@test.com" }
    sequence(:password) { |n| "#{n}"*8 }
  end
end