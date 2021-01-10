class Schedule < ApplicationRecord
  belongs_to :task
  belongs_to :schedule
end
