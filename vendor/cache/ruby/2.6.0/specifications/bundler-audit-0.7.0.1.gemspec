# -*- encoding: utf-8 -*-
# stub: bundler-audit 0.7.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "bundler-audit".freeze
  s.version = "0.7.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.8.0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Postmodern".freeze]
  s.date = "2020-06-13"
  s.description = "bundler-audit provides patch-level verification for Bundled apps.".freeze
  s.email = "postmodern.mod3@gmail.com".freeze
  s.executables = ["bundle-audit".freeze, "bundler-audit".freeze]
  s.extra_rdoc_files = ["COPYING.txt".freeze, "ChangeLog.md".freeze, "README.md".freeze]
  s.files = ["COPYING.txt".freeze, "ChangeLog.md".freeze, "README.md".freeze, "bin/bundle-audit".freeze, "bin/bundler-audit".freeze]
  s.homepage = "https://github.com/rubysec/bundler-audit#readme".freeze
  s.licenses = ["GPL-3.0+".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.2.17".freeze
  s.summary = "Patch-level verification for Bundler".freeze

  s.installed_by_version = "3.2.17" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<thor>.freeze, [">= 0.18", "< 2"])
    s.add_runtime_dependency(%q<bundler>.freeze, [">= 1.2.0", "< 3"])
  else
    s.add_dependency(%q<thor>.freeze, [">= 0.18", "< 2"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.2.0", "< 3"])
  end
end
