require 'bundler/gem_tasks'

desc 'Start an IRB console with Workers loaded'
task :console do
  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

  require 'fiona'
  require 'irb'

  ARGV.clear

  IRB.start
end
