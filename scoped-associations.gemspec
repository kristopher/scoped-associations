# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{scoped-associations}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristopher Chambers"]
  s.date = %q{2008-12-07}
  s.description = %q{DRY up your associations with named_scope conditions!}
  s.email = %q{kristopher.chambers@gmail.com}
  s.extra_rdoc_files = ["CHANGELOG", "lib/scope_reflection.rb", "lib/scoped_associations.rb", "LICENSE", "README.rdoc", "TODO"]
  s.files = ["CHANGELOG", "init.rb", "lib/scope_reflection.rb", "lib/scoped_associations.rb", "LICENSE", "Manifest", "Rakefile", "README.rdoc", "scoped-associations.gemspec", "spec/models.rb", "spec/scoped_associations_spec.rb", "spec/spec_helper.rb", "TODO"]
  s.has_rdoc = true
  s.homepage = %q{}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Scoped-associations", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{scoped-associations}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{DRY up your associations with named_scope conditions!}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<echoe>, [">= 0"])
    else
      s.add_dependency(%q<echoe>, [">= 0"])
    end
  else
    s.add_dependency(%q<echoe>, [">= 0"])
  end
end
