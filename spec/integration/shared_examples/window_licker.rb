require "spec_helper"
require "integration/given"

include RLicker

shared_examples_for "a window licker that can execute javascript" do
  it "can EXECUTE javascript with a return statement" do
    earl = "https://www.google.com/"

    licker.goto earl

    result = licker.execute_script "return document.title"
    
    result.must match /Google/
  end

  it "can EVALUATE javascript" do
    earl = "https://www.google.com/"

    licker.goto earl

    result = licker.evaluate_script "document.title"

    result.must match /Google/
  end
end

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

  it "returns things that are clickable" do
    given earl => <<-HTML
      <button id="phils-bike-seat"></button>
    HTML
  
    licker.goto earl
    licker.find_by_id("phils-bike-seat").click
  end
  
  it "can locate elements by other attributes like href for example" do
    given earl => <<-HTML
      <div id="one">
        <a href="http://example.com"></a>
      </div>
    HTML
      
    licker.goto earl
    licker.find(:href => "http://example.com").must_not be_nil
  end

  it "can locate my regex matching attribute values"
  it "returns nil when attribute does not exist"

  it "when multiple elements have the same id it returns the first one" do
    given earl => <<-HTML
      <div id="phils-bike-seat"></div>
      <span id="phils-bike-seat"></span>
    HTML
      
    licker.goto earl
    licker.find_by_id("phils-bike-seat").must_not be_an Array
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
