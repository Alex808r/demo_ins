class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
      if @comment.save
        flash[:success] = "Комментарий сохранен"
    redirect_to user_article_path(@article.user_id, @article)
    # работает только если оставлять комметы под своим постом
    #redirect_to user_article_path(current_user, @article) выдавало ошибку на метод show article controller
    #redirect_to home_path # РАБОТАЕТ
    #redirect_to article_path(@article) # НЕ РАБОТАЕТ
      else
        flash[:danger] = "Ошибка сохранения комментария"
        redirect_to user_article_path(@article.user_id, @article)
      end

  end


  private

  def comment_params
    params.require(:comment).permit(:author, :body)
  end
end
