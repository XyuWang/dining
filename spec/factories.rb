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
end
