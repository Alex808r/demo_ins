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

  describe '#show' do

    let(:params) { { user_id: user.id, id: article } }

    subject { get :show, params: params }

    let!(:article) { create :article, user: user }

    it 'assigns @article' do
      subject
      expect(assigns(:article)).to eq(article)
    end

    it { is_expected.to render_template('show') }
  end

  # context 'when user tries to see someone elses article' do
  #   let!(:article){create :article}
  #   it {expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
  # end

  # describe '#create' do
  #   let(:params) do
  #     {
  #       user_id: user.id,
  #       article: attributes_for(:article)
  #     }
  #   end
  #
  #   subject { article :create, params: params }
  #
  #   it 'create article' do
  #     expect { subject }.to change { Article.count }.by(1)
  #     is_expected.to redirect_to(user_article_path(assigns(:user),assigns(:article)))
  #   end
  # end
end
DatabaseCleaner.clean