require 'rails_helper'
require 'capybara/rails'
require 'database_cleaner/active_record'

RSpec.describe ArticlesController, type: :controller do

  let(:user) { create :user }
  let(:params) { { user_id: user } }

  before { sign_in user }
  # before { login_as(user) }

  describe '#index' do
    subject { get :index, params: params }

    let!(:article) { create :article, user: user }

    it 'assigns @articles' do
      subject
      expect(assigns(:articles)).to eq([article])
    end

    it { is_expected.to render_template('index') }
  end



end
DatabaseCleaner.clean