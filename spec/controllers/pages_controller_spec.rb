require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #login" do

    context "when user is logged out" do
      it "returns http success" do
        get :login
        expect(response).to have_http_status(:success)
      end
    end

    context "when user is logged in and authorized" do
      it "redirects to customers_main_path" do
        request.env['omniauth.auth'] = FactoryBot.create(:auth_hash, :google)
        @user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
        session[:user_id] = @user.id

        get :login
        expect(response).to redirect_to customers_main_path
      end
    end
  end

  describe "GET #logout" do
    it "returns http success" do
      get :logout
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #unauthorized" do
    it "returns http success" do
      get :unauthorized
      expect(response).to have_http_status(:success)
    end
  end

end
