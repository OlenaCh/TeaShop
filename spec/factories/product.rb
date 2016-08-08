FactoryGirl.define do
  factory :product, class: Product do
    sequence(:title) { |n| "#{n}_title" }
    short_description 'Tea'
    long_description 'Very good tea'
    sequence(:price) { |n| "#{n}" + ".0" }
  end
end