require 'rails_helper'

RSpec.describe UserIp, type: :model do
  context 'validations' do
    it { should validate_presence_of(:ip_address) }
    it { should have_many(:searches).dependent(:destroy) }
  end
end
