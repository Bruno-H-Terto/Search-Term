class HomeController < ApplicationController
  def index
    @user_ip = UserIp.find_or_create_by(ip_address: request.remote_ip)
    @searches = @user_ip&.searches&.order(updated_at: :desc)
  end
end
