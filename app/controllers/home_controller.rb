# frozen_string_literal: true

class HomeController < ApplicationController
  skip_authorization_check
  before_action :set_ranking_variables

  def landing
  end
end
