class ApplicationController < ActionController::Base
  include ActionPolicy::Controller

  authorize :user, through: :current_account
end
