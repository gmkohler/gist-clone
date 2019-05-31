class ApplicationController < ActionController::Base
  def current_user
    return @current_user if defined? @current_user
    token = request.headers["Authorization"].split(" ").last.split("=").last.gsub("\"", "")

    @current_user = User.find(authentication_token: token)
  end
end
