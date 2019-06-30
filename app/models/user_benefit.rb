# frozen_string_literal: true

class UserBenefit < ApplicationRecord
  belongs_to :user
  belongs_to :benefit
end
