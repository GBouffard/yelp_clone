require 'rails_helper'
require 'yelp_helper'

feature 'endorsing reviews' do
  before do
    user_creates_review
  end

  scenario 'a user can endorse a review, which updates the review endorsement count' do
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end

  scenario 'a user can only endorse a review once' do
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).not_to have_link('Endorse Review')
  end
end
