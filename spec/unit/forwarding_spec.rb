require "spec_helper"

include RLicker

describe Forwarding do
  it "can forward a method call to another object" do
    example_inner_class = Class.new do
      def self.ben_rules; true; end
    end

    example_class = Class.new do
      extend Forwarding
      
      forward(:ben_rules) { @inner }

      def initialize(inner)
        @inner = inner
      end
    end

    instance = example_class.new(example_inner_class)

    instance.must respond_to(:ben_rules)
    instance.ben_rules.must === true
  end

  it "extending a module includes its methods in metaclass" do
    example_class = Class.new do
      extend Forwarding      
    end

    example_class.must respond_to(:forward)
  end
end

