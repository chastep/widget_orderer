require 'rails_helper'

RSpec.describe "types/index", type: :view do
  let(:type1) { create(:type, :pro) }
  let(:type2) { create(:type, :xtreme) }

  before(:each) { assign(:types, [type1, type2]) }

  it "renders a list of types" do
    render
    assert_select "tr>td", :text => "widget pro", :count => 1
    assert_select "tr>td", :text => "widget xtreme", :count => 1
  end
end
