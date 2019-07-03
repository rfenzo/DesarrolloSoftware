# frozen_string_literal: true

class Benefit < ApplicationRecord
  belongs_to :company, class_name: 'User', foreign_key: 'user_id'
  has_many :user_benefits
  has_many :donors, through: :user_benefits, source: :user, dependent: :destroy
  has_many :contracts, dependent: :destroy

  attr_reader :coupon_code

  def define_coupon_code(user:)
    @coupon_code = user_benefits.find_by(user_id: user.id).coupon_code
  end

  def to_s
    title
  end
end
