class Project < ApplicationRecord
  belongs_to :user

  has_many :contracts, dependent: :destroy
  has_many :sponsors, through: :contracts, source: :user
  has_many :donations, dependent: :nullify
  has_many :donors, through: :donations, source: :user

  validates_presence_of :user
end
