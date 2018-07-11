require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  render_views

  describe "GET #main" do

    context "when logged in and authorized" do

      before(:each) do
        request.env['omniauth.auth'] = FactoryBot.create(:auth_hash, :google, email: "testuser@test.com")
        @user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
        session[:user_id] = @user.id
        FactoryBot.create(:authorized_user, email: "testuser@test.com")
      end

      it "renders customers_main_path" do
        get :main
        expect(response).to render_template :main
        expect(response).to render_template(partial: '_search_billtoid')
      end

    end

    context "when not logged in" do

      it "redirects to login page" do
        get :main
        expect(response).to redirect_to pages_login_path
      end

    end

    context "when logged in but not authorized" do

      it "redirects to unauthorized page" do
        request.env['omniauth.auth'] = FactoryBot.create(:auth_hash, :google)
        @user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
        session[:user_id] = @user.id
        get :main
        expect(response).to redirect_to pages_unauthorized_path
      end

    end

  end

  describe "GET #search" do

    before(:each) do
      request.env['omniauth.auth'] = FactoryBot.create(:auth_hash, :google)
      FactoryBot.create(:authorized_user)
      @user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
      session[:user_id] = @user.id
    end

    context "when user enters valid BillToID" do
      it "renders customers_main_path" do
        FactoryBot.create(:customer, BillToID: '15684')
        get :search, search: '15684'
        expect(response).to render_template :main
        expect(response).to render_template(partial: '_show_billtoid')
      end

    end

    context "when user enters invalid BillToID" do
      it "renders customers_main_path" do
        get :search, search: '999999999999'
        expect(response).to render_template :main
        expect(response).to_not render_template(partial: '_show_billtoid')
      end

    end

  end

  describe "POST #export" do

    before(:each) do
      request.env['omniauth.auth'] = FactoryBot.create(:auth_hash, :google)
      FactoryBot.create(:authorized_user)
      @user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
      session[:user_id] = @user.id
      customer = FactoryBot.create(:customer, BillToID: "12345")
    end

    context "when user selects 'Export Pre-Migration Data'" do

      it "redirects to customers_search_path" do
        post :export, customer: { BillToID: "12345" }, export_pre_migration_data: "Export Pre-Migration Data"
        expect(response).to redirect_to(customers_search_path(search: '12345'))
      end

    end

    context "when user selects 'Export Post-Migration Data'" do

      it "redirects to customers_search_path" do
        post :export, customer: { BillToID: "12345" }, export_post_migration_data: "Export Post-Migration Data"
        expect(response).to redirect_to(customers_search_path(search: '12345'))
      end
    end

    context "when user selects 'Set Migration Flag'" do

      it "redirects to customers_search_path" do
        post :export, customer: { BillToID: "12345" }, set_migration_flag: "Export Pre-Migration Data"
        expect(response).to redirect_to(customers_search_path(search: '12345'))
      end

    end

    context "when user selects 'Update Customer Name'" do

      it "redirects to customers_search_path" do
        post :export, customer: { BillToID: "12345" }, update_customer_name: "Update Customer Name"
        expect(response).to redirect_to(customers_search_path(search: '12345'))
      end

    end

  end

end
