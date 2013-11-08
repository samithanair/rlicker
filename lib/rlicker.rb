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
        @browser.find "//*[@id='#{id}']"
      end
    end
  end
end

module RLicker
  module Lickers
    class SauceLabsSettings
      class << self
        def username; ENV["sauce_labs_username"]; end
        def access_key; ENV["sauce_labs_accesskey"]; end
        def job_name; ENV["sauce_labs_job_name"]; end
      end
    end

    # For config: https://github.com/saucelabs/sauce_ruby/wiki/Configuration----The-(in)Complete-Guide
    class SauceLabsLicker
      require "capybara"
      require "sauce/capybara"
      require "audible"; include Audible

      def initialize
        ENV["SAUCE_USERNAME"]   = SauceLabsSettings.username
        ENV["SAUCE_ACCESS_KEY"] = SauceLabsSettings.access_key

        Sauce.config do |c|
          c[:job_name] = SauceLabsSettings.job_name
          c[:start_local_application] = false
          c[:browser] = "Chrome"
          c[:browser_version] = nil
          c[:record_screenshots] = false
          c[:command_timeout] = 15
          c[:max_duration] = 300
        end

        Capybara.default_driver = :sauce

        notify :initialized, Sauce.get_config.opts 
      end

      def find_by_id(id)
        driver.find_by_id(id)
      end

      def goto(earl); driver.visit earl; end
      
      def close; end
  
      def status_code; driver.status_code; end

      def url; driver.current_url; end

      def evaluate_script(script); driver.evaluate_script script; end
  
      def execute_script(script); driver.execute_script script; end

      def body; driver.body; end

      private

      def driver; Capybara.current_session; end
    end
  end
end
