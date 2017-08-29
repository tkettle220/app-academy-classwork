require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  subject(:user) {User.create!(username: 'tk')}

  describe 'GET #show' do
    it "renders the show template" do
      get :show, params: {id: user.id}
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #index' do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do

      context "with valid params" do
        it "redirects to the show page" do
          post :create, params: {user: {username: 'tk2'} }
          expect(response).to redirect_to(user_url(User.last))
        end
      end

      context "with invalid params" do
        it "validates the presence of a username" do
          post :create, params: {user: {username: ""}}
          expect(response).to redirect_to(new_user_url)
          expect(flash[:errors]).to be_present
        end

        it "validates the uniqueness of a username" do
          User.create({username: "tk"})
          post :create, params: {user: {username: "tk"}}
          expect(response).to redirect_to(new_user_url)
          expect(flash[:errors]).to be_present
        end
      end
    end
end
