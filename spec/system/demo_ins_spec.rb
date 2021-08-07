require 'rails_helper'

RSpec.describe "DemoIns", type: :system do
  let(:user){create(:user)}

  before do
    driven_by(:rack_test) #самый быстрый из всех. Но не работает с js
    #driven_by(:selenium_chrome) через wls не работает, так как не видит бразуер. Работает с js и открывает окно браузера
    #driven_by(:selenium_chrome_headless) #отличается от второго тем, что не выведет запущенное тестом окно браузера
  end

  describe 'root page' do
    it 'should have valid page' do
      visit('/')
      expect(page).to have_content('Demo instagram')
    end

    it 'should have flash message' do
      visit('/')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end

  describe 'demo_ins' do
    before do         # перед каждым тестовым блоком в этом дискрайбе запускаем хелпер для регистрации
      login_as(user)  # если запусить этот хелпер перед всем тестом, то упадет тест на проверку
    end               # flash message так как флеш не отображается если юзер залогинен

    it 'should have Feed' do
      #login_as(user) можно логинить юзера непосредственно в тестовом блоке
      visit('/feed_articles')
      expect(page).to have_content('Feed - Лента')
    end

  end



end
