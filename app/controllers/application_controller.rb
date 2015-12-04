class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    layout "application"
    helper_method :current_user

    def current_user
        @current_user ||= User.find(session[:user_id_id]) if session[:user_id_id]
    end

    def require_user
        redirect_to '/login' unless current_user
    end

    def require_teacher
        redirect_to 'todos' unless current_user.teacher?
    end

    def require_admin
        redirect_to 'todos' unless current_user.admin?
    end

    def redirect_on_logged_in
	if session[:user_id_id]
	    redirect_to 'todos'
	end
    end

    private

    def redirect_on_logged_in
	if session[:user_id_id]
	    redirect_to 'todos'
	end
    end
end
