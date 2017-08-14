class Log < ApplicationRecord
  # belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
end
