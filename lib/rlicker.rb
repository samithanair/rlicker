module RLicker
  module Forwarding
    def forward(method, &to)
      define_method method do
        target = self.instance_eval &to
        target.send method
      end
    end
  end

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

      def close; end
      
      def find_by_id(id)
        @browser.find "//*[@id='#{id}']"
      end
    end
  end
end
