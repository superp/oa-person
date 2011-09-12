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
  s.homepage = "https://github.com/superp/oa-person"
  
  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.require_paths = ["lib"]
  
  #s.add_runtime_dependency(%q<omniauth>, ["~> 0.2.6"])
  s.add_runtime_dependency(%q<httparty>, ["~> 0.7.8"])
  s.add_runtime_dependency(%q<fb_graph>, ["~> 2.0.1"])
  s.add_runtime_dependency(%q<vk-ruby>, ["~> 0.6.21"])
  #s.add_runtime_dependency(%q<twitter>, ["~> 1.6.2"])
end
