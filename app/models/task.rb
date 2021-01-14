class Task < ApplicationRecord
  belongs_to :user
  has_many :schedules
  validates :content, presence: true, length: {minimum:1, maximum:50}
  validates :duration, presence: true
  validates :comment, length: {maximum: 400}
  validates :completed, inclusion: {in: [true, false]}
end
