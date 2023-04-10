require "rails_helper"

RSpec.describe GatheringOutingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/gathering_outings").to route_to("gathering_outings#index")
    end

    it "routes to #new" do
      expect(get: "/gathering_outings/new").to route_to("gathering_outings#new")
    end

    it "routes to #show" do
      expect(get: "/gathering_outings/1").to route_to("gathering_outings#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/gathering_outings/1/edit").to route_to("gathering_outings#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/gathering_outings").to route_to("gathering_outings#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/gathering_outings/1").to route_to("gathering_outings#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/gathering_outings/1").to route_to("gathering_outings#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/gathering_outings/1").to route_to("gathering_outings#destroy", id: "1")
    end
  end
end
