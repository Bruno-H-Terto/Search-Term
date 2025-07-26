class UserIp < ApplicationRecord
  has_many :searches, dependent: :destroy

  validates :ip_address, presence: true
end
