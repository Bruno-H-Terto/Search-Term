class Search < ApplicationRecord
  belongs_to :user_ip, dependent: :destroy
  validates :term, presence: true

  SIMILARITY_THRESHOLD = 0.7

  def self.find_similar(user_ip_id:, term:)
    sanitized_term = ActiveRecord::Base.sanitize_sql_like(term)
    where(user_ip_id: user_ip_id)
      .where("similarity(term, ?) >= ?", sanitized_term, SIMILARITY_THRESHOLD)
      .order(Arel.sql("similarity(term, #{ActiveRecord::Base.connection.quote(sanitized_term)}) DESC"))
      .first
  end
end
