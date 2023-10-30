require 'rails_helper'

describe UsersController, type: :request do
  before do
    @user = User.create(name: 'Sam', photo: 'photo.url', bio: 'Excellent', posts_counter: 0)
  end

  describe 'GET #index' do
    it 'responds with success' do
      get '/users'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/users'
      expect(response).to render_template('users/index')
      expect(response).to render_template(layout: 'layouts/application')
    end

    it 'assigns @users with all users' do
      get '/users'
      expect(assigns(:users)).to eq(User.all)
    end

    it 'includes the correct placeholder text in the response body' do
      get '/users'
      expect(response.body).to include('Names of all the users')
      expect(response.body).to include('Name: Sam')
      expect(response.body).to include('Posts Counter: 0')
      expect(response.body).to include('Posts: #&lt;ActiveRecord::Associations::CollectionProxy []&gt;')
    end
  end

  describe 'GET #show' do
    it 'responds with success' do
      get "/users/#{@user.id}"
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get "/users/#{@user.id}"
      expect(response).to render_template('users/show')
      expect(response).to render_template(layout: 'layouts/application')
    end

    it 'includes the correct placeholder text in the response body' do
      get "/users/#{@user.id}"
      expect(response.body).to include('this is the detail page for the user with id')
    end
  end
end
