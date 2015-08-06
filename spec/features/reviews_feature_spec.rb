require 'rails_helper'
require 'yelp_helper'

feature 'reviewing' do
  before do
    user_signs_in
    user_creates_restaurant
  end

  scenario 'allows users to leave a review using a form' do
    user_leaves_review
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'a user cannot leave a 2nd review on a restaurant he/she already reviewed' do
    user_leaves_review
    expect(page).not_to have_link 'Review KFC'
  end

  scenario 'only the creator of a review can delete this review' do
    user_leaves_review
    expect(page).to have_link 'Delete KFC review'
    click_link 'Delete KFC review'
    expect(page).to have_link 'Review KFC'
  end

  scenario 'a user cannot delete a review that he/she did not create' do
    user_leaves_review
    other_user_signs_in
    expect(page).not_to have_link 'Delete KFC review'
    expect(page).to have_link 'Review KFC'
  end

  scenario 'displays an average rating as stars for all reviews' do
    leave_review('So so', '3')
    other_user_signs_in
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: ★★★★☆')
  end
end
