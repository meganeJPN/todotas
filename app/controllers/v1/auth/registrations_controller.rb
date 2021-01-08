class V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  protect_from_forgery
end