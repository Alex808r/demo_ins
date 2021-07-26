class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(user)
    user_articles_path(user)
  end


  private

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def hello
     render html: "Hello, this is demo Instagram"
  end
end
