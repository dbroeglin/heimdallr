require 'rake/clean'
require 'rubygems'
require 'rdoc/task'
require 'rubygems/package_task'

Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
  rd.title = 'HeimdallR'
end

spec = eval(File.read('heimdallr.gemspec'))


Gem::PackageTask.new(spec) do |pkg|
  #pkg.need_zip = true
  #pkg.need_tar = true
end

task :default => :test
