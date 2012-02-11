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
    end
  end
end

include RLicker

describe "The capybara-webkit implementation" do
  it "can open an earl" do
    licker = Lickers::CapybaraWebkitLicker.new
    licker.goto "spec/integration/samples/licker_test.html"
  end

  it "after opening an earl, it exposes it" do
    licker = Lickers::CapybaraWebkitLicker.new
    licker.goto "spec/integration/samples/licker_test.html"
    licker.url.must match %r{licker_test.html$}
  end

  it "you can set a base earl and then use relative ones"
  it "after closing it, the process is no longer running"
  it "exposes its pid somehow"
end
