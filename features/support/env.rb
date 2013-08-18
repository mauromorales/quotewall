require 'aruba/cucumber'

LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib')

Before do
  @original_rubylib = ENV['RUBYLIB']
  ENV['RUBYLIB'] = LIB_DIR + File::PATH_SEPARATOR + ENV['RUBYLIB'].to_s
end

After do
  ENV['RUBYLIB'] = @original_rubylib
end
