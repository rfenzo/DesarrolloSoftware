# frozen_string_literal: true

class Benefit < ApplicationRecord
  belongs_to :user
  has_many :contracts

  def to_s
    title
  end
end
