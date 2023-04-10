require 'rails_helper'

RSpec.describe "gathering_outings/new", type: :view do
  before(:each) do
    assign(:gathering_outing, GatheringOuting.new())
  end

  it "renders new gathering_outing form" do
    render

    assert_select "form[action=?][method=?]", gathering_outings_path, "post" do
    end
  end
end
