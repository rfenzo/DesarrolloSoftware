class Benefit < ApplicationRecord
  belongs_to :user
  has_many :contracts
end
