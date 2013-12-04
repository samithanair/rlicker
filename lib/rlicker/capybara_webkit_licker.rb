module RLicker
  module Lickers
    class CapybaraWebkitLicker
      def initialize
        require "capybara-webkit"
        connection = Capybara::Webkit::Connection.new       
        @pid = connection.instance_variable_get :@pid 
        @browser = Capybara::Webkit::Browser.new connection 
      end

      def goto(earl)
        @browser.visit earl
      end
      
      def pid; @pid; end 
      def url; @browser.current_url; end
      def close; end
      
      def find_by_id(id)
        find :id => id
      end

      def find(selector = {})
        attribute_name = selector.keys.first
        attribute_value = selector[attribute_name]
        @browser.find("//*[@#{attribute_name}='#{attribute_value}']").first
      end

      def evaluate_script(what)
        @browser.evaluate_script what 
      end

      def execute_script(what)
        @browser.execute_script what 
      end
    end
  end
end
