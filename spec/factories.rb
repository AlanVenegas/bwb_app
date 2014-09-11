FactoryGirl.define do
  factory :user do
    name     "Mr Potato"
    email    "potato@playskool.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
