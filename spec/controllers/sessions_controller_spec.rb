require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #create" do
    it "sets session[:user_id]" do
      request.env['omniauth.auth'] = FactoryBot.create(:auth_hash, :google)
      get :create
      expect(controller.session[:user_id]).to_not eq(nil)
    end

    it "redirects to customers_main_path" do
      request.env['omniauth.auth'] = FactoryBot.create(:auth_hash, :google)
      get :create
      expect(response).to redirect_to customers_main_path
    end

  end

  describe "GET #destroy" do

    it "clears session[:user_id]" do
      get :destroy
      expect(session[:user_id]).to eq(nil)
    end

    it "redirects to pages_logout_paths" do
      get :destroy
      expect(response).to redirect_to pages_logout_path
    end

  end

end
