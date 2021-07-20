class ApplicationController < ActionController::Base
  def hello
     render html: "Hello, this is demo Instagram"
  end
end
