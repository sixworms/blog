#class ApplicationController < ActionController::Base
#  protect_from_forgery with: :exception
#end

class ApplicationController < ActionController::Base
  protect_from_forgery
  prepend_before_filter :authenticate!

  helper_method :warden, :signed_in?, :current_user

  def signed_in?
    !current_user.nil?
  end

  def current_user
    warden.user
  end

  def warden
    request.env['warden']
  end

  def authenticate!
    warden.authenticate!
  end
end