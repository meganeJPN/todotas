class Schedule < ApplicationRecord
  belongs_to :task
  belongs_to :user

  validates :start_date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
