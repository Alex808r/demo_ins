class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(user)
    user_articles_path(user)
  end

  # rescue_from ActiveRecord::RecordNotFound, with: :notfound отсылаем в метод notfound, а он рендерит страницу из директории
  # паблик, чтобы скрыть от пользователя код в контроллере на котором возникает ошибка.
  # справоцировать ошибку можно путем обращения к несуществующему посту по id
  # обычно это убирают app/controllers/concerns

  #include ErrorHandling # перенесли и подключаем его

  private

  # def notfound(exception)
  #  logger.warn exception # запишем в логи эту ошибку
  #  render file: 'public/404.html', status: :not_found, layout: false
  # end

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def hello # использовалось для стартовой страницы
    render html: "Hello, this is demo Instagram"
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:warning] = "You are not authorized to perform this action."
    redirect_to(request.referrer || home_path)
  end
end
