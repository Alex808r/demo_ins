class ArticlesController < ApplicationController
  include Pundit              # Подключаем политику
  before_action :authenticate_user!  # Необходима регистрация
  before_action :load_user           # Загружаем юзера так как у нас вложенные маршурты и связанные модели

  def index
    #@articles = Article.all   # Все посты
    @articles = @user.articles # Посты только пользователя
  end

  def new
    @article = Article.new
  end

  def edit
    @article = @user.articles.find_by id: params[:id] # или так @article = @user.articles.find(params[:id])
    # find_by ищет по одному или нескольким параметрам, в данном случае задан один параметр для базы данныз "id"
    authorize @article # политика
  end

  def update
    @article = @user.articles.find(params[:id])
    authorize @article # подключение политики
    if @article.update(article_params)
      redirect_to user_articles_path(@user, @article) # вызовет метод show и переведет пользователя на новую страницу
    else
      render 'edit' # перезагрузить страницу, если не прошла валидация
    end
  end

  def create
    @article = Article.new(article_params)
    @article.user = @user
    if @article.save
      flash[:success] = "Пост сохранен" # :success класс bootstrap используем для стилей в визуализации сообщения
      redirect_to user_articles_path(@user, @article)  # ранее было записано"redirect_to article_url(@article)"
      # Ответ от сервера 302 это и есть redirect_to
      # redirect_to - браузеру от сервера приходит ответ переходи на другую страницу
      # Rails из redirect_to @user  автоматически делает вывод о том, что необходимо перенаправить на user_url(@user).
    else
      flash[:danger] = "Ошибка сохранения поста"
      render 'new' # - это значит нужно отрендерить еще раз представление "new.html.erb"
      # это произойдет если не прошла валидация. можно также написать render action: 'new'
      # если в методе "create" мы бы не написали render "new", то нам бы вернулось представление "create.html.erb",
      # но у нас нет такого представления и поэтому мы просто возвращаем action "new" который подтянет представление
      # "new.html.erb"
      #
      # Использовать "redirect_to" в данном случае нельзя, потому, что тогда потеряется переменная "@article" из метода
      # "create" так как "redirect_to" происходит на стороне браузера, а не на стороне сервера.
      # Когда делаем render "new" переменная не теряется.
    end
  end

  def show
    @article = @user.articles.find(params[:id]) # Работчий код
    # ранее получал ошибку на этот метод когда оставляю комменты или лайки другому пользователю
    # если оставлял себе, ошибки не возникало. Проблема была в маршрутах.
    # ActiveRecord::RecordNotFound in ArticlesController#show
    # Couldn't find Article with 'id'=11 [WHERE "articles"."user_id" = ?]
  end

  def destroy
    @article = @user.articles.find(params[:id])
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

  def load_user
    @user = User.find(params[:user_id])
  end
end
