class SearchesController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    query = params[:query].to_s.strip
    return head :bad_request if query.blank?

    UserIp.find_or_create_by(ip_address: request.remote_ip)

    head :ok
  end
end
