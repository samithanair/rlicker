module Lickers
  class ChromeLicker
    require "selenium-webdriver"
    require "capybara-webkit"

    Selenium::WebDriver::Chrome::Bridge.class_eval do
      def initialize(opts = {})
        http_client = opts.delete(:http_client)
        caps        = create_capabilities(opts)
      
        # [BJB] REQUIRED must delete proxy option otherwise server throws this error:
        # "proxy must be of type dictionary, not null. Received: null"
        caps.delete(:proxy)

        @service = Selenium::WebDriver::Chrome::Service.default_service
        @service.start

        remote_opts = {
          :url                  => @service.uri,
          :desired_capabilities => caps
        }

        remote_opts.merge!(:http_client => http_client) if http_client

        super(remote_opts)
      end
    end

    def initialize
      Capybara.register_driver :chrome do |app|   
        Capybara::Selenium::Driver.new(app, :browser => :chrome)
      end

      Selenium::WebDriver::Chrome.path = "/usr/bin/chrome"
      
      @driver = Selenium::WebDriver.for :chrome
    end

    def goto(earl) 
      @driver.navigate.to @current_earl = earl
    end
    def url; @current_earl end
    def body; @driver.page_source; end
    def close
      @driver.close
      rescue
    end
    def find_by_id(id)
      SeleniumElement.new @driver["#{id}"]
    end
  end
end

module Forwardable
  def forward(methods, target_ivar)
    methods = [methods] unless methods.is_a? Array
    methods.each do |m|
      define_method m do
        self.instance_variable_get(target_ivar).send m
      end
    end
  end
end

class SeleniumElement
  extend Forwardable

  def initialize(inner_element)
    @inner_element = inner_element
  end

  def type(text)
    @inner_element.send_keys text
  end

  forward [:click, :inspect], :@inner_element  
end

require "spec_helper"
require "integration/shared_examples/window_licker"

include RLicker

describe "The selenium chrome implementation" do
  let(:licker){Lickers::ChromeLicker.new}
  
  it_behaves_like "a window licker"

  pending do
    it_behaves_like "a window licker that can locate elements"
  end
end
