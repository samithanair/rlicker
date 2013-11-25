require "spec_helper"
require "integration/shared_examples/window_licker"

describe "The chrome implementation" do
  include Given
  let(:licker) { RLicker::Lickers::ChromeLicker.new }
  it_behaves_like "a window licker"
  it_behaves_like "a window licker that can locate elements"

  it "when there are two elements with the same tag name and id it only returns one of them" do
    earl = File.expand_path File.join(".", "spec/integration/samples/licker_test.html")
    
    given earl => <<-HTML
      <div id="a">An element with id "a"</div>
      <div id="a">Another element with id "a"</div>
    HTML

    licker.goto earl
    
    licker.find_by_id("a").must be_a Watir::Div
  end

  after do
    licker.close
  end
end
