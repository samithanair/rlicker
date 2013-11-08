require "spec_helper"
require "integration/shared_examples/window_licker"

describe "The chrome implementation" do
  let(:licker) { RLicker::Lickers::ChromeLicker.new }
  it_behaves_like "a window licker"
  it_behaves_like "a window licker that can locate elements"

  after do
    licker.close
  end
end
