# frozen_string_literal: true

require 'rails_helper'
require 'capybara/rails'
require 'database_cleaner/active_record'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let!(:comment) { create(:comment, article: article, author: user) }

  before { sign_in user }

  describe 'POST #create' do
    context 'with valid attribute' do
      let(:params) { { comment: attributes_for(:comment), user: user, article_id: article } }

      subject { post :create, params: params }

      it 'create comment' do
        expect { subject }.to change { article.comments.count }.by(1)
        is_expected.to redirect_to user_article_path(article.user_id, article)
      end
    end

    context 'with invalid attribute' do
      let(:params) { { comment: attributes_for(:comment, :invalid), user: user, article_id: article } }
      subject { post :create, params: params }

      it 'create article' do
        expect { subject }.to_not change { article.comments.count }
        is_expected.to redirect_to user_article_path(article.user_id, article)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:params) { { article_id: article, id: comment } }

    subject { delete :destroy, params: params }

    it 'delete the comment' do
      expect { subject }.to change { article.comments.count }.by(-1)
    end

    it 'redirect to article' do
      subject
      is_expected.to redirect_to user_article_path(article.user_id, article)
    end
  end
end
