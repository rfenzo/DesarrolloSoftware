class User < ApplicationRecord
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/missing.jpg"
  has_attached_file :validation
  has_attached_file :compromise

  validates_attachment :avatar, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png'] }, size: { in: 0..1000.kilobytes }
  validates_attachment :validation, content_type: { content_type: ['application/pdf'] }, size: { in: 0..2000.kilobytes }
  validates_attachment :compromise, content_type: { content_type: ['application/pdf'] }, size: { in: 0..2000.kilobytes }
  # validates_attachment_presence :validation, if: :requireValidationField
  # validates_attachment_presence :compromise, if: :requireCompromiseField

  validates_presence_of :user_type
  validates_presence_of :name
  validates_presence_of :rut, if: :requireRUTField

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def requireValidationField
    user_type.in?(["Company", "SocialCompany"])
  end

  def requireCompromiseField
    user_type.in?(["Company", "SocialCompany"])
  end

  def requireRUTField
    user_type.in?(["Company", "SocialCompany"])
  end

end
