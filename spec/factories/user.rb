FactoryGirl.define do
  factory :user do
  	sequence(:email) { |x| "user#{x}@email.com" }
    password '12345678'
    password_confirmation '12345678'
  	admin false
  	
  	factory :admin do 
  		admin true
  	end
  end
end
