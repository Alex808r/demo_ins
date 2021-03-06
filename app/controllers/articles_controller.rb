class ArticlesController < ApplicationController
  include Pundit # Подключаем политику
  before_action :authenticate_user!, except: %i[index] # Необходима регистрация
  before_action :load_user! # Загружаем юзера так как у нас вложенные маршурты и связанные модели
  before_action :set_article!, only: %i[show destroy edit update] # вынесли общий код в метод и определили загрузку
  # метода для нужных action

  def index
    # @articles = Article.all  # Все посты
    #@articles = @user.articles # Посты только пользователя

    @articles = @user.articles.order(created_at: :desc).page(params[:page]).per_page(2)
  end

  def new
    @article = Article.new
  end

  def edit
    # @article = @user.articles.find_by id: params[:id] # или так @article = @user.articles.find(params[:id]) вынесли в метод set_article
    # find_by ищет по одному или нескольким параметрам, в данном случае задан один параметр для базы данныз "id"
    authorize @article # политика
  end

  def update
    # @article = @user.articles.find(params[:id]) вынесли в метод set_article
    authorize @article # подключение политики
    if @article.update(article_params)
      redirect_to user_articles_path(@user, @article) # вызовет метод show и переведет пользователя на новую страницу
    else
      render "edit" # перезагрузить страницу, если не прошла валидация
    end
  end

  def create
    @article = Article.new(article_params)
    @article.user = @user
    if @article.save
      flash[:success] = 'Пост сохранен' # :success класс bootstrap используем для стилей в визуализации сообщения
      redirect_to user_articles_path(@user, @article)  # ранее было записано"redirect_to article_url(@article)"
      # Ответ от сервера 302 это и есть redirect_to
      # redirect_to - браузеру от сервера приходит ответ переходи на другую страницу
      # Rails из redirect_to @user  автоматически делает вывод о том, что необходимо перенаправить на user_url(@user).
    else
      flash[:danger] = 'Ошибка сохранения поста.'
      #flash[:danger] = @article.errors.full_messages
      render "new" # - это значит нужно отрендерить еще раз представление "new.html.erb"
      # это произойдет если не прошла валидация. можно также написать render action: 'new'
      # если в методе "create" мы бы не написали render "new", то нам бы вернулось представление "create.html.erb",
      # но у нас нет такого представления и поэтому мы просто возвращаем action "new" который подтянет представление
      # "new.html.erb"

      # Использовать "redirect_to" в данном случае нельзя, потому, что тогда потеряется переменная "@article" из метода
      # "create" так как "redirect_to" происходит на стороне браузера, а не на стороне сервера.
      # Когда делаем render "new" переменная не теряется.
    end
  end

  def show
    # @article = @user.articles.find(params[:id]) # Работчий код вынесли в метод set_article
    # ранее получал ошибку на этот метод когда оставляю комменты или лайки другому пользователю
    # если оставлял себе, ошибки не возникало. Проблема была в маршрутах.
    # ActiveRecord::RecordNotFound in ArticlesController#show
    # Couldn't find Article with 'id'=11 [WHERE "articles"."user_id" = ?]
    @comment  = @article.comments.build
    @comments = @article.comments.order created_at: :desc
  end

  def destroy
    # @article = @user.articles.find(params[:id]) вынесли в метод set_article
    authorize @article
    @article.destroy
    redirect_to action: :index
    # "render" не прерывает запрос текущий, а продолжает его дальше, а "redirect_to" прерывает и отравляет браузер на
    # другую страницу. То есть "redirect_to" делает два запроса: прерывает операцию и отправляет браузер
    # на другую страницу, и переменная теряется, а "render" происходит в рамках текущего запроса,
    # не прерывая его, поэтому сохраняется переменная.
  end


  private

  def article_params 
    params.require(:article).permit(:title, :body, :image)
  end

  def load_user!
    @user = User.find(params[:user_id])
  end

  def set_article!
    @article = @user.articles.find(params[:id])
  end
end