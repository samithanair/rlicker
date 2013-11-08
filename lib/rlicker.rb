lib = File.expand_path(File.join(File.dirname(__FILE__), "rlicker"))

$:.unshift lib

Dir.glob(File.join(lib, "**", "*.rb")).each {|file| require file}
