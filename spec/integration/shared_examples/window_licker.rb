require "spec_helper"
require "integration/given"

include RLicker

shared_examples_for "a window licker that can locate elements" do
  include Given

  it "can locate an element by id" do
    earl = "spec/integration/samples/licker_test.html"
    given earl => <<-HTML
      <div id="phils-bike-seat"></div>
    HTML
      
    licker.goto earl
    licker.find_by_id("phils-bike-seat").must_not be_nil
  end
    
  it "returns all elements with id(, whatever their tagname)" do
    earl = "spec/integration/samples/licker_test.html"
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

  it "can open an earl" do
    earl = "spec/integration/samples/licker_test.html"

    given earl => ""

    lambda{licker.goto "spec/integration/samples/licker_test.html"}.must_not raise_error
  end

  it "after opening an earl it exposes it" do
    earl = "spec/integration/samples/licker_test.html"

    given earl => ""

    licker.goto "spec/integration/samples/licker_test.html"
    licker.url.must match %r{licker_test.html$}
  end

  it "you can set a base earl and then use relative ones"
  it "after closing it, the process is no longer running"
  
  it "exposes its pid somehow" do
    Process.getpgid(licker.pid).must_not be_nil
  end
end
