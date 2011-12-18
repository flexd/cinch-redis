require File.join(File.dirname(__FILE__), 'lib/cinch/storage/redis')
Gem::Specification.new do |s|
  s.name = %q{cinch-redis}
  s.version = Cinch::Storage::Redis::VERSION
  s.date = %q{18/12/2011}
  s.summary = %q{Redis backend for Cinch persistant storage}
  s.files = [
    "Gemfile",
    "Rakefile",
    "lib/cinch/storage/redis.rb",
    "examples/plugins/memo.rb",
    "LICENSE.rdoc",
    "README.rdoc"
  ]
  s.require_paths = ["lib"]
end
