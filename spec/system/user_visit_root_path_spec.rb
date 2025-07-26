require 'rails_helper'

describe 'User visit root path', type: :system do
  it 'with success' do
    visit root_path

    expect(page).to have_content "Serch Term"
    expect(page).not_to have_content "Hello World!"
  end

  it 'with js', js: true do
      visit root_path

    expect(page).to have_content "Serch Term"
    expect(page).to have_content "Hello World!"
  end
end
