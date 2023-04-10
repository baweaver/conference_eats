require 'rails_helper'

RSpec.describe "gathering_outings/edit", type: :view do
  let(:gathering_outing) {
    GatheringOuting.create!()
  }

  before(:each) do
    assign(:gathering_outing, gathering_outing)
  end

  it "renders the edit gathering_outing form" do
    render

    assert_select "form[action=?][method=?]", gathering_outing_path(gathering_outing), "post" do
    end
  end
end
