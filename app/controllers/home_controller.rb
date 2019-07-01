# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_ranking_variables

  def landing
    projects = Project.all
    projects.map(&:calculate_donations)
    @random_project = projects.sample
    @most_donated = projects.max_by(&:total_donations)
    @recent_projects = projects.order(:created_at).first(3)
    @recent_projects.map(&:calculate_donations)
    @most_sponsored = Contract.group(:project).count.max[0]
  end
end
