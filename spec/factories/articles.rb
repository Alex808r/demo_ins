# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  body       :text
#  image_data :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
FactoryBot.define do

  factory :article do
    sequence(:title){ |n| "Title #{n}" }
    sequence(:body) { |n| "Body #{n}"  }
    association(:user)
    image {Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test_file.png'),'image/jpeg')}


    trait(:with_invalid_image) do
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test_file.txt')) }
    end

    # Эти варианты не сработали
    #image_data { fixture_file_upload 'spec/fixtures/test_file.png' }
    # trait :image do
    #   image { fixture_file_upload(Rails.root.join('spec/fixtures/test_file.png')) }
    # end
  end


end
