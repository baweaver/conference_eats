require 'rails_helper'

RSpec.describe "gathering_outings/show", type: :view do
  before(:each) do
    assign(:gathering_outing, GatheringOuting.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
