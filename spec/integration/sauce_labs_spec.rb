require "spec_helper"
require "integration/shared_examples/window_licker"

describe "The saucelabs implementation" do
  let(:licker) { RLicker::Lickers::SauceLabsLicker.new }

  it_behaves_like "a window licker that can execute javascript"

  it "can locate elements by id" do
    licker.goto "http://www.bbc.co.uk"
    licker.find_by_id("blq-search-q").should_not be_nil
  end
end
