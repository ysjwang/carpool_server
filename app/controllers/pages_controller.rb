class PagesController < ApplicationController
  def home
  end

  def token_test_user
    @user = User.find_by_email('devise_test_user@email.com')
  end
end
