# README

demo_ins

Курсовой проект Инстаграм с использованием Ruby on Rails.
Проект размещен на heroku: https://young-refuge-44402.herokuapp.com
Основные функции:
Пользователь должен зарегистрироваться в приложении, после чего может создавать посты, просматривать свои посты,
просматривать и изменять свой профиль, оставлять комментарии к постам, оставлять/удалять лайки к постам, подписываться 
/отписываться на другого пользователя, просматривать ленту постов тех пользователей, на которых подписан, просматривать 
список всех зарегистрированных пользователей и их посты. 
Пользователь может редактировать или удалить только свои посты, редактировать только свой профиль.  
  
  
Регистрация пользователя - gem devise
Загрузка изображений - gem shrine
Политика допустимых действия пользователя - gem pundit
Визуальное оформление bootstrap 4.6.0.


Для тестирования приложения используется:
gem rspec-rails,
gem factory_bot_rails
gem database_cleaner-active_record
gem shoulda-matchers

Отображение структуры модели в тестах: 
gem annotate


