require 'rake/clean'
require 'rubygems'
require 'rake/gempackagetask'
require 'rake/rdoctask'

Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
  rd.title = 'HeimdallR'
end

spec = eval(File.read('heimdallr.gemspec'))

Rake::GemPackageTask.new(spec) do |pkg|
end

task :default => :test
