require 'spec/rake/spectask'

require 'echoe'
Echoe.new 'scoped-associations' do |p|
  p.description     = "DRY up your associations with named_scope conditions!"
  # p.url             = "http://scoped-associations.rubyforge.org"
  p.author          = "Kristopher Chambers"
  p.email           = "kristopher.chambers@gmail.com"
  p.retain_gemspec  = true
  p.need_tar_gz     = false
  p.extra_deps      = [
  ]
end

desc 'Default: run specs'
task :default => :spec
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList["spec/**/*_spec.rb"]
end

task :test => :spec
