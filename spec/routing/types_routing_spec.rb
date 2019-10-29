require "rails_helper"

RSpec.describe TypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/types").to route_to("types#index")
    end

    it "routes to #show" do
      expect(:get => "/types/1").to route_to("types#show", :id => "1")
    end
  end
end
