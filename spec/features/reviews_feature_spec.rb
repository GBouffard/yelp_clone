require 'rails_helper'
require 'yelp_helper'

feature 'reviewing' do
  before do
    user_signs_in
    user_creates_restaurant
    user_leaves_review
  end

  scenario 'allows users to leave a review using a form' do
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'a user cannot leave a 2nd review on a restaurant he/she already reviewed' do
    expect(page).not_to have_link 'Review KFC'
  end

  scenario 'a review can be deleted' do
    expect(page).to have_link 'Delete KFC review'
    click_link 'Delete KFC review'
    expect(page).to have_link 'Review KFC'
  end
end
