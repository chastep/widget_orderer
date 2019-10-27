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

  xdescribe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  xdescribe "GET #edit" do
    it "returns a success response" do
      get :edit, params: {id: type.to_param}
      expect(response).to be_successful
    end
  end

  xdescribe "POST #create" do
    context "with valid params" do
      it "creates a new Type" do
        expect {
          post :create, params: {type: valid_attributes}
        }.to change(Type, :count).by(1)
      end

      it "redirects to the created type" do
        post :create, params: {type: valid_attributes}
        expect(response).to redirect_to(Type.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {type: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  xdescribe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: 'widget xtreme'
        }
      }

      it "updates the requested type" do
        put :update, params: {id: type.to_param, type: new_attributes}
        type.reload
        expect(type.name).to eq('widget xtreme')
      end

      it "redirects to the type" do
        put :update, params: {id: type.to_param, type: valid_attributes}
        expect(response).to redirect_to(type)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: {id: type.to_param, type: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  xdescribe "DELETE #destroy" do
    it "destroys the requested type" do
      type2 = Type.create! valid_attributes
      expect {
        delete :destroy, params: {id: type2.to_param}
      }.to change(Type, :count).by(-1)
    end

    it "redirects to the types list" do
      type2 = Type.create! valid_attributes
      delete :destroy, params: {id: type2.to_param}
      expect(response).to redirect_to(types_url)
    end
  end
end
