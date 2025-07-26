class Search < ApplicationRecord
  belongs_to :user_ip
  validates :term, presence: true
  validates :term, uniqueness: { scope: :user_ip_id, case_sensitive: true }

  after_commit :broadcast_search

  private

  def broadcast_search
    broadcast_prepend_later_to(
      user_ip_searches_key,
      target: "searches",
      partial: "searches/search",
      locals: { search: self }
    )
  end

  def user_ip_searches_key
    "searches_user_#{user_ip_id}"
  end

  SIMILARITY_THRESHOLD = 0.5

  def self.find_similar(user_ip_id:, term:)
    sanitized_term = ActiveRecord::Base.sanitize_sql_like(term)
    where(user_ip_id: user_ip_id)
      .where("similarity(term, ?) >= ?", sanitized_term, SIMILARITY_THRESHOLD)
      .order(Arel.sql("similarity(term, #{ActiveRecord::Base.connection.quote(sanitized_term)}) DESC"))
      .first
  end
end
