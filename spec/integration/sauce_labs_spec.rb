require "spec_helper"
require "integration/shared_examples/window_licker"

include RLicker

describe "The saucelabs implementation" do
  let(:licker) { Lickers::SauceLabsLicker.new }
  it_behaves_like "a window licker"
  it_behaves_like "a window licker that can locate elements"
end
