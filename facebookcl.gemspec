# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{facebookcl}
  s.version = "0.3.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin Bishop"]
  s.date = %q{2010-06-25}
  s.default_executable = %q{facebook}
  s.description = %q{Retrofacebook.  Interact via the commandline.}
  s.email = %q{jubishop@facebook.com}
  s.executables = ["facebook"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "bin/facebook",
     "commands/base.rb",
     "commands/help.rb",
     "commands/info.rb",
     "commands/picture.rb",
     "commands/stream.rb",
     "commands/wall.rb",
     "facebookcl.gemspec",
     "lib/facebook_server.rb",
     "lib/facebookcl.rb"
  ]
  s.homepage = %q{http://github.com/jubishop/facebookcl}
  s.post_install_message = %q{
===========================================================

           Thanks for installing FacebookCL!
           Just run 'facebook' to start...

===========================================================

}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Facebook Command Line}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<json>, [">= 0"])
  end
end

