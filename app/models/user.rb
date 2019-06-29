# frozen_string_literal: true

class User < ApplicationRecord
  has_many :benefits, dependent: :destroy
  has_many :contracts, through: :benefits
  has_many :sponsored_projects, through: :contracts, source: :project

  has_many :projects
  has_many :requirements

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
