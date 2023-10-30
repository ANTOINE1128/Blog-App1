require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns a success response' do
      get users_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include('This is a list of users')
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      get '/users'
      expect(response.body).to include('Names of all the users')
      expect(response.body).to include('Name: Sam')
      expect(response.body).to include('Posts Counter: 0')
      expect(response.body).to include('Posts: #&lt;ActiveRecord::Associations::CollectionProxy []&gt;')
    end
  end

  describe 'GET /show' do
    it 'returns a success response' do
      user = User.create!(name: 'Name', posts_counter: 0)
      get user_path(user)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Here is detail of a specific user')
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      get "/users/#{@user.id}"
      expect(response.body).to include('this is the detail page for the user with id')
    end
  end
end
