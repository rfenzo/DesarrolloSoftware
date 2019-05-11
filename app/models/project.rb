class Project < ApplicationRecord
  belongs_to :user

  has_many :contracts
  has_many :sponsors, through: :contracts, source: :user
  has_many :donations
  has_many :donors, through: :donations, source: :user

  validates_presence_of :user

  def to_s
    self.name
  end
end
