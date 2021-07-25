class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article # вызовет метод show и переведет пользователя на новую страницу
    else
      render 'edit' # перезагрузка страницы если не прошла валидация
    end
  end


  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Пост сохранен"
      redirect_to @article  # можно записать так "redirect_to article_url(@article)" Rails из redirect_to @article
      # автоматически делает вывод о том, что необходимо перенаправить на user_url(@user).

    else
      render 'new'
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
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path

    # "render" не прерывает запрос текущий, а продолжает его дальше, а "redirect_to" прерывает и отравляет браузер на
    # другую страницу. То есть "redirect_to" делает два запроса: прерывает операцию и отправляет браузер
    # на другую страницу, и переменная теряется, а "render" происходит в рамках текущего запроса,
    # не прерывая его,  поэтому сохраняется переменная.
  end



  private

  def article_params
    params.require(:article).permit(:title, :body,:image)
  end

end
