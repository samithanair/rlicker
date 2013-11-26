require "spec_helper"
require "integration/shared_examples/window_licker"

describe "The saucelabs implementation" do
  let(:licker) { RLicker::Lickers::SauceLabsLicker.new }

  it_behaves_like "a window licker that can execute javascript"

  it "handles multiples with the same id by returning the first" do
    licker.goto "https://login.xero.com"
    licker.find_by_id("email").must_not be_an Array
    licker.find_by_id("email").must_not be_nil
  end

  it "can find elements by other attributes like class for example" do
    licker.goto "https://login.xero.com/"
    licker.find(:href => "http://www.xero.com/about/").must_not be_nil
  end
end
