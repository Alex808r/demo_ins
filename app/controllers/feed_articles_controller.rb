class FeedArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.followings.exists?
      @articles = Article.where(user_id: current_user.followings.pluck(:id)).order(created_at: :desc)
    else
      Article.none
    end
      render 'articles/index'
  end

  def show
    render 'articles/show'
  end

end
