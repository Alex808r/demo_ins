class CommentsController < ApplicationController
  #before_action :load_user
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to home_path #   РАБОТАЕТ
      #redirect_to article_path(@article) #НЕ РАБОТАЕТ
  end

  # def create
  #   @post = Post.find(params[:post_id])
  #   @comment = @post.comments.create(comment_params)
  #   redirect_to post_path(@post)
  # end


  private
  def comment_params
    params.require(:comment).permit(:author, :body)
  end

end
