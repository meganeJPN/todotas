class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token, if: :devise_controller?
  protect_from_forgery with: :null_session
  CONST_START_TIME = "08:00"
  CONST_END_TIME = "22:00"
  CONST_TIME_PITCH = 15
  CONST_TIME_PITCH_NUM = (Time.zone.parse(CONST_END_TIME) - Time.zone.parse(CONST_START_TIME)).to_i/60/CONST_TIME_PITCH
  
end
