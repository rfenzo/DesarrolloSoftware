class ProfileController < ApplicationController
  def index
  end

  def my_data
  end

  def my_donations
    @donations = current_user.donations.reverse
    @total_amount = @donations.sum(&:amount)
  end

  def my_benefits
  end

  def my_social_projects
  end

  def my_sponsored_projects
  end

  def my_offered_benefits
  end

  def find_sponsor
  end
end
