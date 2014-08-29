FactoryGirl.define do
  factory :user do
    name "Arnab"
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "arnabpaul"
    password_confirmation "arnabpaul"
    
    factory :admin do
      admin true
    end
  end
  
  factory :micropost do
    content "Lorem ipsum"
    user
  end

  factory :relationship do
    user
  end
end
