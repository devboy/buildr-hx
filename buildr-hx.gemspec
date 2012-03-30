# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "buildr-hx"
  s.version = "0.0.18.pre"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dominic Graefen"]
  s.date = "2012-03-30"
  s.description = "Build like you code - now supporting haXe"
  s.email = "dominic @nospam@ devboy.org"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "buildr-hx.gemspec",
    "buildr-hx.iml",
    "lib/buildr/hx.rb",
    "lib/buildr/hx/compiler.rb",
    "lib/buildr/hx/compiler/haxe_compiler_base.rb",
    "lib/buildr/hx/compiler/hxas3.rb",
    "lib/buildr/hx/compiler/hxcpp.rb",
    "lib/buildr/hx/compiler/hxjs.rb",
    "lib/buildr/hx/compiler/hxlib.rb",
    "lib/buildr/hx/compiler/hxneko.rb",
    "lib/buildr/hx/compiler/hxphp.rb",
    "lib/buildr/hx/compiler/hxswf.rb",
    "lib/buildr/hx/compiler/hxxml.rb",
    "lib/buildr/hx/core.rb",
    "lib/buildr/hx/core/haxe_lib.rb",
    "lib/buildr/hx/packaging.rb",
    "lib/buildr/hx/packaging/haxelib.rb",
    "lib/buildr/hx/packaging/hxlib.rb",
    "lib/buildr/hx/test.rb",
    "lib/buildr/hx/test/base.rb",
    "lib/buildr/hx/test/munit.rb",
    "rake/jeweler.rb",
    "rake/jeweler_prerelease_tasks.rb",
    "rake/pre_release_gemspec.rb",
    "rake/pre_release_to_git.rb",
    "spec/hx/compiler/hxswf_spec.rb",
    "spec/sandbox.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/devboy/buildr-hx"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.21"
  s.summary = "Buildr extension to allow haXe development."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<buildr>, ["~> 1.4.6"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.1.3"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<simplecov-rcov>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.1.0"])
      s.add_development_dependency(%q<ci_reporter>, ["~> 1.6.5"])
      s.add_runtime_dependency(%q<buildr>, [">= 1.4.6"])
    else
      s.add_dependency(%q<buildr>, ["~> 1.4.6"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.1.3"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<simplecov-rcov>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.1.0"])
      s.add_dependency(%q<ci_reporter>, ["~> 1.6.5"])
      s.add_dependency(%q<buildr>, [">= 1.4.6"])
    end
  else
    s.add_dependency(%q<buildr>, ["~> 1.4.6"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.1.3"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<simplecov-rcov>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.1.0"])
    s.add_dependency(%q<ci_reporter>, ["~> 1.6.5"])
    s.add_dependency(%q<buildr>, [">= 1.4.6"])
  end
end

