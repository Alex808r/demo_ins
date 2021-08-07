require 'rails_helper'

RSpec.describe Follow, type: :model do

  describe "follow associations" do
    it { should belong_to(:follower)  }
    it { should belong_to(:following) }
  end

end