
def user_signs_in
  @guillaume = User.create(email: 'guillaume@yelp.com', password: 'thepassword', password_confirmation: 'thepassword')
  visit('/')
  click_link('Sign in')
  fill_in('Email', with: 'guillaume@yelp.com')
  fill_in('Password', with: 'thepassword')
  click_button('Log in')
end

def user_creates_restaurant
  @guillaume.restaurants.create name: 'KFC'
end

def user_creates_review
  user_signs_in
  @kfc = user_creates_restaurant
  @kfc.reviews.create(rating: 3, thoughts: 'It was an abomination')
end

def other_user_signs_in
  click_link('Sign out')
  @eviltwin = User.create(email: 'eviltwin@yelp.com', password: 'dapassword', password_confirmation: 'dapassword')
  visit('/')
  click_link('Sign in')
  fill_in('Email', with: 'eviltwin@yelp.com')
  fill_in('Password', with: 'dapassword')
  click_button('Log in')
end

def user_leaves_review
  visit '/restaurants'
  click_link 'Review KFC'
  fill_in 'Thoughts', with: 'so so'
  select '3', from: 'Rating'
  click_button 'Leave Review'
end

def leave_review(thoughts, rating)
  visit '/restaurants'
  click_link 'Review KFC'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end
