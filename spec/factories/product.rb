FactoryGirl.define do
  factory :product, class: Product do
    sequence(:title) { |n| "#{n}_title" }
    short_description 'Tea'
    long_description 'Very good tea'
    price 1000.0
  end
end