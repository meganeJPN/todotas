class Task < ApplicationRecord
  validates :content, presence: true
  validates :duration, presence: true
end
