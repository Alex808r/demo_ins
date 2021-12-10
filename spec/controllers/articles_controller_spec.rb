require 'rails_helper'
require 'capybara/rails'
require 'database_cleaner/active_record'

RSpec.describe ArticlesController, type: :controller do

  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:params) { { user_id: user } }

  before { sign_in user }

  describe 'GET #index' do
   let(:articles) { create_list(:article, 2, user: user ) }
   subject { get :index, params: params }

    it 'assigns @articles' do
      subject
      # expect(assigns(:articles)).to eq([article])
      expect(assigns(:articles)).to match_array(articles)
    end

    it { is_expected.to render_template('index') }
  end

  describe 'GET #show' do
    let(:params) { { user_id: article.user.id, id: article } }
    subject { get :show, params: params }

    it 'assigns @article' do
      subject
      expect(assigns(:article)).to eq(article)
    end

    it { is_expected.to render_template('show') }
  end

    context 'when user tries to see someone elses article' do
      let(:params) { { user_id: nil, id: article } }
      subject { get :show, params: params }
      
      it {expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end

  describe 'GET #new' do
    subject { get :new, params: params }
    
    it 'assigns new article' do
      subject
      expect(assigns(:article)).to be_a_new Article
    end
    
    it { is_expected.to render_template :new }
  end

  describe 'POST #create' do
    context 'with valid attribute' do
    let(:params) { { article: attributes_for(:article), user_id: user.id } }
    subject { post :create, params: params }
    
      it 'create article' do
        expect { subject }.to change { Article.count }.by(1)
        is_expected.to redirect_to user_articles_path(assigns(:user), assigns(:article))
      end
    end

    context 'with invalid attribute' do
      let(:params) { { article: attributes_for(:article, :with_invalid_image), user_id: user.id } }
      subject { post :create, params: params }
      
      it 'create article' do
        expect { subject }.to_not change { Article.count }
        # is_expected.to redirect_to user_articles_path(assigns(:user), assigns(:article))
      end
    end
  end
  
  describe 'GET #edit' do
    let(:params) { { user_id: article.user, id: article } }
    subject{ get :edit, params: params }

    it 'assigns @article' do
      subject
      expect(assigns(:article)).to eq(article)
    end

    it { is_expected.to render_template('edit') }
  end
  
  describe 'PATCH #update' do
    let(:params){ { user_id: article.user, id: article, article: attributes_for(:article) } }
    subject { patch :update, params: params }

    it 'assigns @article' do
      subject
      expect(assigns(:article)).to eq(article)
    end

    it { is_expected.to redirect_to user_articles_path(assigns(:user), assigns(:article)) }
  end

end
DatabaseCleaner.clean