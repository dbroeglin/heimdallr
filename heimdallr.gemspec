# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "heimdallr/version"

Gem::Specification.new do |s|
  s.name        = "heimdallr"
  s.version     = Heimdallr::VERSION
  s.authors     = ["Dominique Broeglin"]
  s.email       = ["dominique.broeglin@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Heimdallr is a toolbox to help troubleshoot network VoIP issues}
  s.description = %q{Heimdallr helps troubleshoot network VoIP issues by providing a set of simple tools for executing common tasks. It leverages tools like tshark and tcpdump.}

  s.rubyforge_project = "heimdallr"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency("nokogiri", "~> 1.5")
  s.add_runtime_dependency("gli", "~> 1.3")

  s.add_development_dependency("rspec", "~> 2.0.1")
  s.add_development_dependency("watchr", "~> 0.7")
  s.add_development_dependency("bundler", ">= 1.0.21")
end
