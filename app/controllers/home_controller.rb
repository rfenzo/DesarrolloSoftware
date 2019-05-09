class HomeController < ApplicationController
  def landing
    @companies = User.where(user_type: 'Company').limit(20)
  end
end
