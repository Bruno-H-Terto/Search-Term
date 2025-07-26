class SearchesController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    query = params[:query].to_s.strip
    return head :bad_request if query.blank?

    user_ip = UserIp.find_or_create_by(ip_address: request.remote_ip)

    similar_term = Search.find_similar(user_ip_id: user_ip.id, term: query)
    last_term = user_ip.searches.last

    if last_term && query.start_with?(last_term.term)
      last_term.update!(term: query)
    elsif similar_term
      similar_term.update!(term: query)
    else
      user_ip.searches.create!(term: query)
    end

    head :ok
  end
end
