FactoryGirl.define do
  factory :user, class: User do
    name 'User'    
    sequence(:email) { |n| "email_#{n}@test.com" }
    sequence(:password) { |n| "#{n}"*8 }
    role 'user'
  end

  factory :admin, class: User do
    name 'Admin'    
    sequence(:email) { |n| "admin_email_#{n}@test.com" }
    sequence(:password) { |n| "#{n}"*8 }
    role 'admin'
  end
end