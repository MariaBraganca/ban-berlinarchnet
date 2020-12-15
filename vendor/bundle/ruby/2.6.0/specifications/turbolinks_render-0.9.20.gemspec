# -*- encoding: utf-8 -*-
# stub: turbolinks_render 0.9.20 ruby lib

Gem::Specification.new do |s|
  s.name = "turbolinks_render".freeze
  s.version = "0.9.20"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jorge Manrubia".freeze]
  s.date = "2020-05-16"
  s.description = "Use render in your Rails controllers and handle the response with Turbolinks.".freeze
  s.email = ["jorge.manrubia@gmail.com".freeze]
  s.homepage = "https://github.com/jorgemanrubia/turbolinks_render".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Use Rails render with Turbolinks".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rails>.freeze, [">= 5.2.0"])
    s.add_runtime_dependency(%q<turbolinks-source>.freeze, ["~> 5.1"])
    s.add_development_dependency(%q<capybara>.freeze, [">= 0"])
    s.add_development_dependency(%q<puma>.freeze, [">= 0"])
    s.add_development_dependency(%q<selenium-webdriver>.freeze, [">= 0"])
    s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_development_dependency(%q<turbolinks>.freeze, [">= 0"])
    s.add_development_dependency(%q<webdrivers>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rails>.freeze, [">= 5.2.0"])
    s.add_dependency(%q<turbolinks-source>.freeze, ["~> 5.1"])
    s.add_dependency(%q<capybara>.freeze, [">= 0"])
    s.add_dependency(%q<puma>.freeze, [">= 0"])
    s.add_dependency(%q<selenium-webdriver>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<turbolinks>.freeze, [">= 0"])
    s.add_dependency(%q<webdrivers>.freeze, [">= 0"])
  end
end
