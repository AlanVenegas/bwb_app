FactoryGirl.define do
	factory :user do
		sequence(:name)  { |n| "Mr #{n}" }
		sequence(:email) { |n| "mr_#{n}@example.com"}
		password "foobar"
		password_confirmation "foobar"
		factory :admin do
			admin true
		end
	end
	factory :question do
		title "Lorem ipsum"
    content "Lorem ipsum"
    user
  end

end
