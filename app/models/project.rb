# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user

  has_many :requirements, dependent: :destroy

  has_many :contracts, dependent: :destroy
  has_many :benefits, through: :contracts

  has_many :donations, dependent: :nullify
  has_many :donors, through: :donations, source: :user

  validates_presence_of :user

  attr_reader :total_donations

  def calculate_donations
    @total_donations = donations.sum(&:amount)
  end

  def to_s
    name
  end
end
