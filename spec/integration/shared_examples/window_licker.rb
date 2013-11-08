require "spec_helper"
require "integration/given"

include RLicker

shared_examples_for "a window licker that can locate elements" do
  include Given

  let(:earl) do
    File.expand_path File.join(".", "spec/integration/samples/licker_test.html")
  end
  
  it "can locate an element by id" do
    given earl => <<-HTML
      <div id="phils-bike-seat"></div>
    HTML
      
    licker.goto earl
    licker.find_by_id("phils-bike-seat").must_not be_nil
  end
    
  it "returns all elements with id(, whatever their tagname)" do
    given earl => <<-HTML
      <div id="phils-bike-seat"></div>
      <span id="phils-bike-seat"></span>
    HTML
      
    licker.goto earl
    licker.find_by_id("phils-bike-seat").size.must == 2
  end
end

shared_examples_for "a window licker" do 
  include Given

  let(:earl) do
    File.expand_path File.join(".", "spec/integration/samples/licker_test.html")
  end

  it "can open an earl" do
    given earl => ""

    lambda{licker.goto "spec/integration/samples/licker_test.html"}.must_not raise_error
  end
end
