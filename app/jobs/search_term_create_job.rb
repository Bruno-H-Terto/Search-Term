class SearchTermCreateJob < ApplicationJob
  self.queue_adapter = :solid_queue

  def perform(user_ip:, term:)
    similar_term = Search.find_similar(user_ip_id: user_ip.id, term: term)
    last_term = user_ip.searches.last

    if last_term && term.start_with?(last_term.term)
      last_term.update!(term: term)
    elsif similar_term
      similar_term.update!(term: term)
    else
      user_ip.searches.create!(term: term)
    end
  end
end
