require 'rails_helper'

RSpec.describe "types/edit", type: :view do
  let(:type) { create(:type) }

  before(:each) { @type = assign(:type, type) }

  xit "renders the edit type form" do
    render

    assert_select "form[action=?][method=?]", type_path(@type), "post" do

      assert_select "input[name=?]", "type[name]"
    end
  end
end
