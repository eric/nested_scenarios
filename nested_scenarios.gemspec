Gem::Specification.new do |s|
  s.name     = "grit"
  s.version  = "0.1"
  s.date     = "2008-11-29"
  s.summary  = "FixtureScenarios, FixtureScenariosBuilder, Yaml and Ruby in one big mix for Rails"
  s.email    = "jose.valim@gmail.com"
  s.homepage = "http://github.com/josevalim/nested_scenarios"
  s.description = "FixtureScenarios, FixtureScenariosBuilder, Yaml and Ruby in one big mix for Rails"
  s.has_rdoc = true
  s.authors  = [ "José Valim" ]
  s.files    = [
    "MIT-LICENSE",
		"README",
		"Rakefile",
		"mested_scenarios.gemspec",
		"init.rb",
		"lib/join.rb",
		"lib/fixtures.rb",
    "lib/nested_scenarios.rb",
    "lib/builder.rb",
    "tasks/builder_tasks.rake"
  ]
  s.test_files = []
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["README"]
end
