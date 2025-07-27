require 'rails_helper'

describe 'User type a search', type: :system, js: true do
  it 'and sends a new term' do
    UserIp.create!(ip_address: '127.0.0.1')

    visit root_path
    expect(page).not_to have_content 'rails'

    fill_in 'searchInput', with: 'rails'

    sleep 1
    perform_enqueued_jobs do
      expect(page).to have_content('rails')
    end
  end

  it 'and sends a part of last term' do
    user = UserIp.create!(ip_address: '127.0.0.1')
    user.searches.create!(term: 'rails')

    visit root_path
    expect(page).to have_content 'rails'

    fill_in 'searchInput', with: 'rails is'

    sleep 1
    perform_enqueued_jobs do
      expect(page).to have_content('rails is')
      expect(user.searches.last.term).to eq 'rails is'
      expect(user.searches.count).to eq 1
    end
  end

  it 'and sends a similar term' do
    user = UserIp.create!(ip_address: '127.0.0.1')
    user.searches.create!(term: 'this')
    user.searches.create!(term: 'other thing')

    visit root_path
    expect(page).to have_content 'this'
    expect(page).to have_content 'other thing'

    fill_in 'searchInput', with: 'this 2'

    sleep 1
    perform_enqueued_jobs do
      expect(page).to have_content('this 2')
      expect(user.searches.first.term).to eq 'this 2'
      expect(user.searches.last.term).to eq 'other thing'
      expect(user.searches.count).to eq 2
    end
  end

  it 'and sends multiples terms' do
    user = UserIp.create!(ip_address: '127.0.0.1')
    user.searches.create!(term: 'rails')

    visit root_path
    expect(page).to have_content 'rails'

    fill_in 'searchInput', with: 'new term'

    sleep 1
    perform_enqueued_jobs do
      expect(page).to have_content('rails')
      expect(page).to have_content('new term')
    end
  end

  it 'and can see only your terms' do
    other_user = UserIp.create!(ip_address: '128.0.0.1')
    other_user.searches.create!(term: 'other term')
    user = UserIp.create!(ip_address: '127.0.0.1')
    user.searches.create!(term: 'rails')

    visit root_path

    expect(page).to have_content('rails')
    expect(page).not_to have_content('other term')
  end
end
