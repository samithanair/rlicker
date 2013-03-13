module RLicker
  module Lickers
    class CapybaraWebkitLicker
      require "capybara-webkit"

      def initialize
        @browser = Capybara::Webkit::Browser.new Capybara::Webkit::Connection.new
      end

      def goto(earl)
        @browser.visit earl
      end
      
      def pid; @browser.instance_variable_get :@pid; end 
      def url; @browser.current_url; end
      def close; end
      
      def find_by_id(id)
        @browser.find "//*[@id='#{id}']"
      end
    end
  end
end
