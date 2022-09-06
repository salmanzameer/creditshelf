class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, notice: "You are not authorized to perform this action."
  end
end
