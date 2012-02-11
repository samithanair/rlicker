require "spec_helper"

module RLicker
  module Lickers
    class CapybaraWebkitLicker
      require "capybara-webkit"

      def initialize
        @browser = Capybara::Driver::Webkit::Browser.new
      end

      def goto(earl)
        @browser.visit earl
      end
      
      def url; @browser.url; end 
      def pid; @browser.instance_variable_get :@pid; end 
    end
  end
end

include RLicker

shared_examples_for "a window licker" do 
  it "can open an earl" do
    lambda{licker.goto "spec/integration/samples/licker_test.html"}.must_not raise_error
  end

  it "after opening an earl, it exposes it" do
    licker.goto "spec/integration/samples/licker_test.html"
    licker.url.must match %r{licker_test.html$}
  end

  it "you can set a base earl and then use relative ones"
  it "after closing it, the process is no longer running"
  
  it "exposes its pid somehow" do
    Process.getpgid(licker.pid).must_not be_nil
  end
end

describe "The capybara-webkit implementation" do
  let(:licker) { Lickers::CapybaraWebkitLicker.new }
  it_behaves_like "a window licker"
end
