require 'rails_helper'

RSpec.describe "types/show", type: :view do
  let(:type) { create(:type) }

  before(:each) { @type = assign(:type, type) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
