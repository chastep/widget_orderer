require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  let(:order) { create(:order) }

  before(:each) { @order = assign(:order, order) }

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do
    end
  end
end
