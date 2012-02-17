require "spec_helper"
require "integration/shared_examples/window_licker"

include RLicker

module Lickers
  class FirefoxLicker
    require "selenium-webdriver"

    def initialize
      @driver = Selenium::WebDriver.for :firefox
    end

    def goto(earl)
      earl = "file://#{earl}"

      @driver.navigate.to earl
    end

    def url
      @driver.current_url
    end

    def pid
      bridge = @driver.instance_variable_get(:@bridge)
      launcher = bridge.instance_variable_get(:@launcher)
      binary = launcher.instance_variable_get(:@binary)
      process = binary.instance_variable_get(:@process)
      process.pid
    end
  end
end

describe "The capybara-webkit implementation" do
  let(:licker) { Lickers::FirefoxLicker.new }
  
  it_behaves_like "a window licker"

  pending "WIP" do
    it_behaves_like "a window licker that can locate elements"
  end
end
