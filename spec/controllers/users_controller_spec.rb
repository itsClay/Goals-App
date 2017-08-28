require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    # it "returns http success" do
    #   get :new
    #   expect(response).to have_http_status(:success)
    # end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context 'with invalid params' do
      it "validates the length of password is greater >= 6" do
        post :create, params: { user: { username: 'Jack Johnson', password: '123' } }
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end

      it "validates the presence of username and password" do
        post :create, params: { user: { username: 'Jack Johnson', password: '' } }
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end

    context 'with valid params' do

      it 'redirects to users page after success' do
        post :create, params: { user: { username: 'Jack Johnson', password: '123456' } }
        expect(response).to redirect_to(users_url)
      end

      it 'logs in the user' do
        post :create, params: { user: { username: 'Jack Johnson', password: '123456' } }
        user = User.find_by(username: 'Jack Johnson')

        expect(session[:session_token]).to eq(user.session_token)
      end
    end
  end
end
