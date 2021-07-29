class ArticlesController < ApplicationController
  include Pundit
  #before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :load_user

  def index
    #@articles = Article.all # Все посты
    @articles = @user.articles # Посты только пользователя
  end

  def new
    @article = Article.new
  end

  def edit
    @article = @user.articles.find(params[:id])
    authorize @article
  end

  def update
    @article = @user.articles.find(params[:id])
    authorize @article
    if @article.update(article_params)
      redirect_to user_articles_path(@user, @article) # вызовет метод show и переведет пользователя на новую страницу
    else
      render 'edit' # перезагрузка страницы если не прошла валидация
    end
  end


  def create
    @article = Article.new(article_params)
    @article.user = @user
    if @article.save
      flash[:success] = "Пост сохранен"

      redirect_to user_articles_path(@user, @article)  # ранее было записано"redirect_to article_url(@article)"
      # Rails из redirect_to @article
      # автоматически делает вывод о том, что необходимо перенаправить на user_url(@user).

    else
      flash[:alert] = "Ошибка сохранения поста"
      render 'new' #, flash[:alert] = "Ошибка сохранения поста"
      # перезагрузка страницы если не прошла валидация можно написать render action: 'new'
      # если в методе "create" мы бы не написали render "new", то нам бы вернулось представление "create.html.erb",
      # но у нас нет такого представления и поэтому мы просто возвращаем action "new" который подтянет представление
      # "new.html.erb"
      #
      # Использовать "redirect_to" в данном случае нельзя, потому, что тогда потеряется переменная "@post" из метода
      # "create" так как "redirect_to" происходит на стороне браузера, а не на стороне сервера.
      # Когда делаем render "new" переменная не теряется.
    end
  end
  def show
    @article = @user.articles.find(params[:id])
  end

  def destroy
    @article = @user.articles.find(params[:id])
    authorize @article
    @article.destroy
    redirect_to action: :index

    # "render" не прерывает запрос текущий, а продолжает его дальше, а "redirect_to" прерывает и отравляет браузер на
    # другую страницу. То есть "redirect_to" делает два запроса: прерывает операцию и отправляет браузер
    # на другую страницу, и переменная теряется, а "render" происходит в рамках текущего запроса,
    # не прерывая его,  поэтому сохраняется переменная.
  end


  private

  def article_params
    params.require(:article).permit(:title, :body,:image)
  end

  def load_user
    @user = User.find(params[:user_id])
  end

end
