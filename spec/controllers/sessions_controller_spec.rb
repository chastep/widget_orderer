require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:valid_attributes) {
    {
      username: ENV['ADMIN_USERNAME'],
      password: ENV['ADMIN_PASSWORD']
    }
  }
  let(:invalid_attributes) {
    {
      username: 'foo',
      password: 'bar'
    }
  }

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "sets session[:admin]" do
        post :create, params: { user: valid_attributes }

        expect(session[:admin]).to be(true)
      end

      it "redirects to the orders page" do
        post :create, params: { user: valid_attributes }

        expect(response).to redirect_to(orders_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { user: invalid_attributes }

        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the session" do
      post :create, params: { user: valid_attributes }
      expect(session[:admin]).to be(true)
      delete :destroy
      expect(session[:admin]).to be(nil)
    end

    it "redirects to the orders list" do
      post :create, params: { user: valid_attributes }
      expect(session[:admin]).to be(true)
      delete :destroy
      expect(response).to redirect_to(orders_path)
    end
  end
end
