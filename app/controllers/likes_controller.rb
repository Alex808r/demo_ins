class LikesController < ApplicationController
  before_action :find_article
  before_action :find_like, only: [:destroy]
  # def create
  #   @article.likes.create(user_id:current_user.id)
  #   redirect_to user_article_path(current_user, @article)
  # end

  def create
    if already_liked?
      flash[:notice] = "Вы не можете поставить больше одного Like"
    else
      @article.likes.create(user_id: current_user.id)
    end
      #render plain: params
        redirect_to user_article_path(current_user, @article)
      #redirect_to article_path(@article)
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
      #render plain: params
      redirect_to user_article_path(current_user, @article)
      #redirect_to article_path(@article)
  end

  def find_like
    @like = @article.likes.find(params[:id])
  end

  private
  def find_article
    @article = Article.find(params[:article_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, article_id: params[:article_id]).exists?
  end
end
