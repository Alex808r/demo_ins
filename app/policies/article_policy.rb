class ArticlePolicy < ApplicationPolicy

  def initialize(user, article)
    @user = user
    @article = article
  end

  def index?
    true
  end

  def edit?
    user.articles.where(id: @article.id).exists?
  end

  def update?
    user.articles.where(id: @article.id).exists?
      #return true if user.present? && user == article.user
  end

  def destroy?
    user.articles.where(id: @article.id).exists?
  end

  private

  # def article
  #   record
  # end
end
