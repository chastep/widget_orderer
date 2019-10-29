require 'rails_helper'

RSpec.describe TypesController, type: :controller do
  let(:type) { create(:type) }
  let(:valid_attributes) {
    {
      name: 'widget'
    }
  }
  let(:invalid_attributes) {
    {
      name: 'widget bad'
    }
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: {id: type.to_param}
      expect(response).to be_successful
    end
  end
end
