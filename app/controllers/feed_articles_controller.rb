class FeedArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.followings.exists?
      # @articles = Article.where(user_id: current_user.followings.pluck(:id)).order(created_at: :desc) аналогичная запись более правильная по style guide
      @articles = Article.where(user_id: current_user.followings.ids).order(created_at: :desc).page(params[:page]).per_page(1)
      #@user.articles.order(created_at: :desc).page params[:page]
    else
      Article.none
    end
      render 'articles/index'
  end
end
