module RLicker
  module Lickers
    class ChromeLicker
      def visit(earl)
        browser.goto ChromeEarl.new(earl).to_s
      end
  
      alias :goto :visit
    
      def find_by_id(id) # todo: try a chain
        result = []
      
        result << browser.text_field(:id, id);
        result << browser.button(:id, id);
        result << browser.form(:id, id);
        result << browser.link(:id, id);
        result << browser.div(:id, id); 
        result << browser.span(:id, id);
      
        result.select{|it| it.exists?}
      end

      def screenshot; fail "Not supported."; end

      def close; @browser.close if @browser; end

      def evaluate_script(what)
        browser.execute_script "javascript:#{what}"
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
        @value.start_with? /http/
      end
    end
  end
end
