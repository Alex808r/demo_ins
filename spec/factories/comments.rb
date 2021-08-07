FactoryBot.define do
  factory :comment do
    sequence(:author){ |n| "Author #{n}" }
    sequence(:body) { |n| "Comment #{n}"  }
    association(:article)
  end
end
