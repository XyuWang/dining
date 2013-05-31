Factory.sequence(:email) { |n| "user#{n}@ope.ope" }
Factory.sequence(:name) { |n| "username_#{n}" }

FactoryGirl.define do
  factory :user do
    email {Factory.next :email}
    name {Factory.next :name}
    password 'password'
    password_confirmation 'password'
  end

  factory :product do
    title "title"
    description "description"
    price 10.0
    association :store,  factory: :store
  end

  factory :store do
    name "name"
    description "description"
    free_deliver_price 30.0
    association :user,  factory: :user
  end

  factory :line_item do
    price 6.5
    quantity 1
    association :product, factory: :product
    association :user, factory: :user
  end

  factory :order do
    association :user, factory: :user
    association :store, factory: :store
    association :line_items, factory: :line_item
    phone "18354211111"
    address "xxxxxxxx"
  end
end
