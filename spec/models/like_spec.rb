require 'rails_helper'

RSpec.describe Like, type: :model do

  describe "like associations" do
    it { should belong_to(:user)    }
    it { should belong_to(:article) }
  end

end
