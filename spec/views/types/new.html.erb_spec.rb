require 'rails_helper'

RSpec.describe "types/new", type: :view do
  let(:type) { create(:type) }

  before(:each) { @type = assign(:type, type) }

  xit "renders new type form" do
    render

    assert_select "form[action=?][method=?]", types_path, "post" do

      assert_select "input[name=?]", "type[name]"
    end
  end
end
