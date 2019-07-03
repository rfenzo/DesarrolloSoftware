# frozen_string_literal: true

class Requirement < ApplicationRecord
  belongs_to :project
  belongs_to :user
end
