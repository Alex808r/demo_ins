class UserPolicy < ApplicationPolicy

  def initialize(user, article)
    @user = user
    @article = article
  end

  def edit?
    true
      #user == current_user
  end

  def update?
    true
    #user == current_user
    #return true if user.present? && user == article.user
  end

  def destroy?
    #user == current_user
  end

end
