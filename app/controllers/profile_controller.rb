class ProfileController < ApplicationController
  before_action :set_profile_bar_variable

  def index
  end

  def my_data
  end

  def my_donations
  end

  def my_benefits
  end

  def my_social_projects
  end

  def find_sponsor
  end

  def my_sponsored_projects
  end

  def my_offered_benefits
  end

  private

  def set_profile_bar_variable
    @render_profile_bar = true
  end
end
