require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  before do
    @user = User.create(name: 'Marco', photo: 'https://image.com/image.jpg', bio: 'Text for Bio', posts_counter: 0)
    5.times do |i|
      Post.create(title: "Post #{i + 1}", author: @user, comments_counter: 0, likes_counter: 0)
    end
  end

  scenario "I can see the user's profile picture" do
    visit user_path(@user)
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end

  scenario "I can see the user's username" do
    visit user_path(@user)
    expect(page).to have_content(@user.name)
  end

  scenario 'I can see the number of posts the user has written' do
    visit user_path(@user)
    expect(page).to have_content('Number of posts: 5')
  end

  scenario "I can see the user's bio" do
    visit user_path(@user)
    expect(page).to have_content(@user.bio)
  end
end

RSpec.feature 'User show page', type: :feature do
  before do
    @user = User.create(name: 'Marco', photo: 'https://image.com/image.jpg', bio: 'Text for Bio', posts_counter: 0)
    5.times do |i|
      Post.create(title: "Post #{i + 1}", author: @user, comments_counter: 0, likes_counter: 0)
    end
  end

  scenario "I can see a button that lets me view all of a user's posts" do
    visit user_path(@user)
    expect(page).to have_link('See all posts')
  end

#  add more test cases here 


end
