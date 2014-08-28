FactoryGirl.define do
  factory :user do
    name "Arnab"
    email "arnabphhhahhhbggul@mail.com"
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
end
