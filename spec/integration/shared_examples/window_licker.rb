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

  after do
    licker.close
  end

  it "can open an earl" do
    earl = map "spec/integration/samples/licker_test.html"

    given earl => ""

    lambda{licker.goto earl}.must_not raise_error
  end

  it "after opening an earl it exposes it" do
    earl = map "spec/integration/samples/licker_test.html"

    given earl => ""

    licker.goto earl
    licker.url.must match %r{licker_test.html$}
  end

  it "you can set a base earl and then use relative ones"
  
  it "you can close it" do
    lambda{licker.close}.must_not raise_error
  end

  pending "closing twice does not throw error either"

  private 

  def map(relative_earl)
    File.join Dir.pwd, relative_earl
  end
end
