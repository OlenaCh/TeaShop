FactoryGirl.define do
  factory :user do
    name "MyString"
    zip_code "MyString"
    city "MyString"
    address "MyString"
    email "MyString@ukr.net"
    password "1234567890"
  end
end

# FactoryGirl.define do
#   factory :user, class: User do
#     sequence(:name) { |i| "Name #{i}" }
#     sequence(:zip_code){ |i| "Zip Code #{i}" }
#     sequence(:city) { |i| "City #{i}" }
#     sequence(:address){ |i| "Address #{i}" }
#     sequence(:email) { |i| "email_#{i}@test.com" }
#     sequence(:password) { |i| "#{i}"*8 }
#     reset_password_token { Faker::Number.number(10) }
#     reset_password_sent_at Time.zone.now
#     # email_notification { true }
#   end
# end