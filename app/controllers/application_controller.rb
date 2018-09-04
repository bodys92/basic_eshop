class ApplicationController < ActionController::Base
    include SessionsHelper

private
    def logged_in_user
        unless logged_in?
          remember_location
          flash[:danger] = "Please log in"
          redirect_to login_path
        end
    end

    def admin?
        redirect_to(root_url) unless current_user.admin?  
    end
end
