class Task < ApplicationRecord
  belongs_to :user
  has_many :schedules
  validates :content, presence: true
  validates :duration, presence: true
end
