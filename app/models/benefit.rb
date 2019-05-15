class Benefit < ApplicationRecord
  belongs_to :user
  has_many :contracts

  def to_s
    self.title
  end
end
