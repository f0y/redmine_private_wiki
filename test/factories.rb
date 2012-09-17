FactoryGirl.define do

  factory :project do
    sequence(:name) {|i| "Name #{i} "}
    sequence(:identifier) {|i| "ident#{i}"}
  end

  factory :wiki do
    start_page "Wiki"
  end

  factory :wiki_page do
    sequence(:title) {|i| "Title#{i}"}
  end

  factory :role do
    sequence(:name) {|i| "Name#{i}"}
  end

  factory :member do
  end

  factory :user do
    sequence(:login) {|i| "login#{i}"}
    sequence(:firstname) {|i| "firstname#{i}"}
    sequence(:lastname) {|i| "lastname#{i}"}
    sequence(:mail) {|i| "login#{i}@example.net"}
  end

end