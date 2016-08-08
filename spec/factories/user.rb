FactoryGirl.define do
  factory :user, class: User do
    name 'User'
    zip_code '79000'
    city 'City'
    address 'Address'
    sequence(:email) { |n| "email_#{n}@test.com" }
    sequence(:password) { |n| "#{n}"*8 }
    role 'user'
  end

  factory :admin, class: User do
    name 'Admin'
    zip_code '79000'
    city 'City'
    address 'Address'
    sequence(:email) { |n| "admin_email_#{n}@test.com" }
    sequence(:password) { |n| "#{n}"*8 }
    role 'admin'
  end
end