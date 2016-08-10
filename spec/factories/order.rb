FactoryGirl.define do
  factory :order, class: Order do
    sequence(:shipment) { |n| "#{n}" + ".0" }
    sequence(:subtotal) { |n| "#{n}" + ".0" }
    sequence(:grand_total) { "#{shipment + subtotal}" }
  end
end