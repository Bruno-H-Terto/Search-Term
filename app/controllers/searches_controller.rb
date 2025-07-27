class SearchesController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    query = params[:query].to_s.strip
    return head :bad_request if query.blank?

    user_ip = UserIp.find_by(ip_address: request.remote_ip)
    return head :not_found unless user_ip

    SearchTermCreateJob.perform_later(user_ip: user_ip, term: query)

    head :ok
  end
end
