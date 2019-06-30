# frozen_string_literal: true

class User < ApplicationRecord
  # Donor and Company
  has_many :user_benefits
  has_many :earned_benefits, through: :user_benefits, source: :benefit

  # Company
  has_many :offered_benefits, class_name: 'Benefit'
  has_many :contracts, through: :offered_benefits
  has_many :sponsored_projects, through: :contracts, source: :project

  # SocialCompany
  has_many :projects

  # Company
  # (SocialCompany can get his pending requirements by looking through his proyects requirements)
  has_many :requirements

  # Donor and Company
  has_many :donations
  has_many :donated_projects, through: :donations, source: :project

  has_attached_file :avatar,
                    styles:      { medium: '300x300>', thumb: '100x100>' },
                    default_url: '/images/missing.jpg'
  has_attached_file :validation
  has_attached_file :compromise

  validates_attachment :avatar,
                       content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png'] },
                       size:         { in: 0..1000.kilobytes }
  validates_attachment :validation,
                       content_type: { content_type: ['application/pdf'] },
                       size:         { in: 0..2000.kilobytes }
  validates_attachment :compromise,
                       content_type: { content_type: ['application/pdf'] },
                       size:         { in: 0..2000.kilobytes }
  # validates_attachment_presence :validation, if: :require_validation_field
  # validates_attachment_presence :compromise, if: :require_compromise_field

  validates_presence_of :user_type
  validates_presence_of :name
  validates_presence_of :rut, if: :require_rut_field

  attr_reader :total_donations

  def calculate_donations
    @total_donations = donations.sum(&:amount)
  end

  def to_s
    name
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def require_validation_field
    user_type.in?(%w[Company SocialCompany])
  end

  def require_compromise_field
    user_type.in?(%w[Company SocialCompany])
  end

  def require_rut_field
    user_type.in?(%w[Company SocialCompany])
  end
end
