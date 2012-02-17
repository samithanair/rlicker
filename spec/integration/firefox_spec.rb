require "spec_helper"
require "integration/shared_examples/window_licker"

include RLicker

module Lickers
  class FirefoxLicker
  
  end
end

describe "The capybara-webkit implementation" do
  let(:licker) { Lickers::FirefoxLicker.new }
  pending do
    it_behaves_like "a window licker"
    it_behaves_like "a window licker that can locate elements"
  end
end
