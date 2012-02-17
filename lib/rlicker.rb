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
      
      def find_by_id(id)
        @browser.find "//*[@id='#{id}']"
      end
    end
  end
end