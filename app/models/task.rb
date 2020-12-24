class Task < ApplicationRecord
  has_many :schedules
  validates :content, presence: true
  validates :duration, presence: true
end
