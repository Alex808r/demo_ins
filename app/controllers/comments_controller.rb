class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
      if @comment.save
        flash[:success] = "Комментарий сохранен"
        redirect_to user_article_path(@article.user_id, @article) # тут был неправильный путь
                                                                  # redirect_to user_article_path(current_user, @article)
                                                                  # работал только если оставлять комметы под своим постом
                                                                  # выдавал ошибку на метод show article controller
                                                                  #redirect_to home_path # РАБОТАЕТ
                                                                  #redirect_to article_path(@article) # НЕ РАБОТАЕТ
      else
        flash[:danger] = "Ошибка сохранения комментария"
        redirect_to user_article_path(@article.user_id, @article)
      end

  end


  private
  # метод в том числе принимает user_id, который нужен для отображения имени пользователя оставивщего комментарий.
  # оговорка о том, что возомжно это неверно в articles show. user_id берем из current_user.id
  # user_id передаем в форме создания комментария через: form.hidden_field :user_id, value: current_user.id
  # Модели User и comment не свазаны на уровне базы данных через has many belongs to

  def comment_params
    params.require(:comment).permit(:author, :body, :user_id)
  end
end
