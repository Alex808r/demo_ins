class UserPolicy < ApplicationPolicy
  #attr_reader :user

  def initialize(user, updated_user)
    @current_user = user
    @updated_user = updated_user
  end

  def edit?
    @current_user == @updated_user
  end

  def update?
    @current_user == @updated_user
  end

  def destroy?
    #@current_user == @updated_user
  end

end
