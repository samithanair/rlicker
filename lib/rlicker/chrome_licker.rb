module RLicker
  module Lickers
    class ChromeLicker
      require "audible"; include Audible

      def visit(earl)
        browser.goto ChromeEarl.new(earl).to_s
      end
  
      alias :goto :visit
    
      def find_by_id(id)
        find(:id => id)
      end

      def find(selector = {})
        return nil if selector.empty?

        attribute_name = selector.keys.first
        attribute_value = selector[attribute_name]

        browser.element(attribute_name.to_sym, attribute_value)
      end

      def screenshot; fail "Not supported."; end

      def close; @browser.close if @browser; end

      def evaluate_script(what)
        execute_script what
      end

      def execute_script(what)
        browser.execute_script "javascript:#{what}"
      end
      
      def url; browser.url; end
    
      private
    
      def browser
        require 'watir-webdriver'
        
        @browser ||= new_browser
      end 
    
      def new_browser; @browser = Watir::Browser.new :chrome; end

      def all
        [:text_field, :button, :form, :link, :div, :span, :h1, :h2, :h3, :h4, :h5]
      end
    end

    class ChromeEarl
      def initialize(value)
        @value = value
      end

      def to_s
        return "file://#{@value}" unless starts_with_scheme
        @value
      end

      private

      def starts_with_scheme
        @value.start_with? "http"
      end
    end
  end
end
