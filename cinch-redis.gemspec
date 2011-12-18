Gem::Specification.new do |s|
  s.name = %q{cinch-redis}
  s.version = "0.1"
  s.date = %q{2011-12-18}
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
