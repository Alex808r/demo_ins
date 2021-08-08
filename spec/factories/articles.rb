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
    image {Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/pixel.png'),'image/jpeg')}

    # Эти варианты не сработали
    #image_data { fixture_file_upload 'spec/fixtures/pixel.png' }
    # trait :with_image do
    #   image { fixture_file_upload(Rails.root.join('spec/fixtures/pixel.png')) }
    # end
  end

end
