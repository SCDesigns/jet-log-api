class User < ApplicationRecord
  has_many :logs

  has_secure_password

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
