FactoryGirl.define do
  factory :coupon do
    code { Faker::Lorem.characters(20) }
    discount { Faker::Number.decimal(2) }
    start_date { Faker::Date.backward(14) }
    end_date { Faker::Date.forward(23) }
  end

  factory :coupon_expired, class: Coupon do
    code { Faker::Lorem.characters(20) }
    discount { Faker::Number.decimal(2) }
    start_date { Faker::Date.backward(14) }
    end_date { Faker::Date.backward(1) }
  end
end
