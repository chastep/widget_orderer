require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:type) { create(:type) }
  let(:order) { create(:order) }
  let(:valid_attributes) {
    {
      quantity: 5,
      color: Order::VALID_COLORS.sample,
      deliver_by: Time.current + 1.week,
      type_id: type.id
    }
  }
  let(:valid_attributes_with_email) {
    {
      quantity: 5,
      color: Order::VALID_COLORS.sample,
      deliver_by: Time.current + 1.week,
      type_id: type.id,
      email: 'test@email.com'
    }
  }
  let(:invalid_attributes) {
    {
      quantity: -1,
      color: 'green',
      deliver_by: Time.current + 1.day,
      type_id: nil
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
      get :show, params: {id: order.to_param}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: {id: order.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Order" do
        expect {
          post :create, params: { order: valid_attributes }
        }.to change(Order, :count).by(1)
        expect(ActionMailer::Base.deliveries).to be_empty
      end

      it "creates a new Order with email present" do
        expect {
          post :create, params: { order: valid_attributes_with_email }
        }.to change(Order, :count).by(1)
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

      it "redirects to the created order" do
        post :create, params: { order: valid_attributes }
        expect(response).to redirect_to(Order.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { order: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:type_2) { create(:type, :pro) }
      let(:new_attributes) {
        {
          quantity: 20,
          color: Order::VALID_COLORS.sample,
          deliver_by: Time.current + 2.week,
          type_id: type_2.id
        }
      }

      it "updates the requested order" do
        put :update, params: {id: order.id, order: new_attributes}
        order.reload
        expect(order.quantity).to eql(20)
      end

      it "does not update the order uuid" do
        expect {
          put :update, params: {id: order.id, order: new_attributes.merge(uuid: 'test123')}
        }.to_not change(order, :uuid)
      end

      it "redirects to the order" do
        put :update, params: {id: order.to_param, order: new_attributes}
        expect(response).to redirect_to(order)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: {id: order.to_param, order: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #ship" do
    context "with valid params and admin session" do
      it "ships the requested order" do
        session[:admin] = true
        put :ship, params: {id: order.id}
        order.reload
        expect(order.status).to eql('shipped')
      end

      it "redirects to the order" do
        put :ship, params: {id: order.to_param}
        expect(response).to redirect_to(order)
      end
    end

    context "with valid params and invalid admin session" do
      it "ships the requested order" do
        put :ship, params: {id: order.id}
        order.reload
        expect(order.status).to eql('pending')
      end

      it "redirects to the order" do
        put :ship, params: {id: order.to_param}
        expect(response).to redirect_to(order)
      end
    end

    context "with a non-pending order" do
      it "returns a success response (i.e. to display 'show' template with notice)" do
        order = create(:order, status: 'shipped')
        put :ship, params: {id: order.to_param}

        expect(response).to_not be_successful
        expect(response).to redirect_to(order)
      end

      it "returns a success response (i.e. to display 'show' template with notice)" do
        order = create(:order, status: 'completed')
        put :ship, params: {id: order.to_param}

        expect(response).to_not be_successful
        expect(response).to redirect_to(order)
      end
    end
  end

  describe "PUT #complete" do
    context "with valid params and admin session" do
      it "completes the requested order" do
        session[:admin] = true
        order = create(:order, status: 'shipped')
        put :complete, params: {id: order.id}
        order.reload
        expect(order.status).to eql('completed')
      end

      it "redirects to the order" do
        put :complete, params: {id: order.to_param}
        expect(response).to redirect_to(order)
      end
    end

    context "with valid params and invalid admin session" do
      it "completes the requested order" do
        order = create(:order, status: 'shipped')
        put :complete, params: {id: order.id}
        order.reload
        expect(order.status).to eql('shipped')
      end

      it "redirects to the order" do
        put :complete, params: {id: order.to_param}
        expect(response).to redirect_to(order)
      end
    end

    context "with a non-pending order" do
      it "returns a success response (i.e. to display 'show' template with notice)" do
        order = create(:order, status: 'pending')
        put :complete, params: {id: order.to_param}

        expect(response).to_not be_successful
        expect(response).to redirect_to(order)
      end

      it "returns a success response (i.e. to display 'show' template with notice)" do
        order = create(:order, status: 'completed')
        put :complete, params: {id: order.to_param}

        expect(response).to_not be_successful
        expect(response).to redirect_to(order)
      end
    end
  end
  

  describe "DELETE #destroy" do
    it "destroys the requested order" do
      order2 = Order.create! valid_attributes
      expect {
        delete :destroy, params: {id: order2.to_param}
      }.to change(Order, :count).by(-1)
    end

    it "redirects to the orders list" do
      order2 = Order.create! valid_attributes
      delete :destroy, params: {id: order2.to_param}
      expect(response).to redirect_to(orders_url)
    end
  end
end
