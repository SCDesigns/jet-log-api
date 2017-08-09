class Log < ApplicationRecord
  belongs_to :user

  mount_uploader :memory, LogUploader

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
end
