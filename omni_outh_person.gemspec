# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "oa_person/version"

Gem::Specification.new do |s|
  s.name = "oa-person"
  s.version = OaPerson::VERSION.dup
  s.platform = Gem::Platform::RUBY 
  s.summary = "omni_auth standart methods for person model"
  s.description = "omni_auth standart methods for person model"
  s.authors = ["Pavel Galeta"]
  s.email = "superp1987@gmail.com"
  s.rubyforge_project = "oa-person"
  s.homepage = "https://github.com/superp/omni_auth_person"
  
  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.require_paths = ["lib"]
end
