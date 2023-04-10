require 'rails_helper'

RSpec.describe "gathering_outings/index", type: :view do
  before(:each) do
    assign(:gathering_outings, [
      GatheringOuting.create!(),
      GatheringOuting.create!()
    ])
  end

  it "renders a list of gathering_outings" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
