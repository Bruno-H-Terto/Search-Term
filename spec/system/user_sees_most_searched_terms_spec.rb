require 'rails_helper'

describe 'Most searched terms with multiple users', type: :system, js: true do
  it 'shows correct searches per user and updates global top terms' do
    user1 = UserIp.create!(ip_address: '127.0.0.1')
    user2 = UserIp.create!(ip_address: '128.0.0.1')
    user1.searches.create!(term: 'ruby')
    user2.searches.create!(term: 'rails')
    user2.searches.create!(term: 'ruby')

    visit root_path

    within '#searches' do
      expect(page).to have_content('ruby')
      expect(page).not_to have_content('rails')
    end

    within '#top-searches-list' do
      expect(page).to have_content('ruby (2)')
      expect(page).to have_content('rails (1)')
    end
  end
end
