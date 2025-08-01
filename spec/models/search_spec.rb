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

  describe ".top_terms" do
    it "returns the most searched terms in descending order" do
      user_ip_1 = UserIp.create!(ip_address: '198.0.0.1')
      user_ip_2 = UserIp.create!(ip_address: '200.0.0.1')
      Search.create!(term: 'rails', user_ip: user_ip_1)
      Search.create!(term: 'turbo', user_ip: user_ip_1)
      Search.create!(term: 'rails', user_ip: user_ip_2)

      result = Search.top_terms
      expect(result.keys).to eq([ "rails", "turbo" ])
      expect(result["rails"]).to eq(2)
      expect(result["turbo"]).to eq(1)
    end

    it "returns an empty hash if there are no searches" do
      Search.delete_all
      expect(Search.top_terms).to eq({})
    end
  end
end
