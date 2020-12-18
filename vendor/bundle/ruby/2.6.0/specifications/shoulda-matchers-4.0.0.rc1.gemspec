# -*- encoding: utf-8 -*-
# stub: shoulda-matchers 4.0.0.rc1 ruby lib

Gem::Specification.new do |s|
  s.name = "shoulda-matchers".freeze
  s.version = "4.0.0.rc1"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tammer Saleh".freeze, "Joe Ferris".freeze, "Ryan McGeary".freeze, "Dan Croak".freeze, "Matt Jankowski".freeze, "Stafford Brunk".freeze, "Elliot Winkler".freeze]
  s.date = "2018-10-02"
  s.description = "Making tests easy on the fingers and eyes".freeze
  s.email = "support@thoughtbot.com".freeze
  s.executables = ["setup".freeze]
  s.files = ["bin/setup".freeze]
  s.homepage = "https://matchers.shoulda.io/".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.0".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Making tests easy on the fingers and eyes".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 4.2.0"])
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 4.2.0"])
  end
end
