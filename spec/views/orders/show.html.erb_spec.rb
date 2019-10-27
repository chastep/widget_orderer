require 'rails_helper'

RSpec.describe "orders/show", type: :view do
  let(:order) { create(:order) }

  before(:each) { @order = assign(:order, order) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Quantity/)
  end
end
