FactoryGirl.define do
  factory :order, class: Order do  
    subtotal 10.0
    grand_total 0.0
  end
end