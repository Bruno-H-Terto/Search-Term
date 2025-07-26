require 'rails_helper'

RSpec.describe Search, type: :model do
  context "unique user_ip and term" do
    it "is case-insensitive when checking uniqueness" do
      user_ip = UserIp.create!(ip_address: '198.0.0.1')
      Search.create!(term: 'Something', user_ip: user_ip)
      duplicate = Search.new(term: 'something', user_ip: user_ip)

      expect(duplicate).not_to be_valid
    end
  end

  context 'validations' do
    it { should belong_to(:user_ip) }
    it { should validate_presence_of(:term) }
  end
end
