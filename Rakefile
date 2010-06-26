require 'rubygems'
require 'rake'

task :default do; end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "facebookcl"
    gem.summary = %Q{Facebook Command Line}
    gem.description = %Q{Retrofacebook.  Interact via the commandline.}
    gem.email = "jubishop@facebook.com"
    gem.homepage = "http://github.com/jubishop/facebookcl"
    gem.authors = ["Justin Bishop"]
    gem.executables = ['facebook']
    gem.add_dependency 'json'
    gem.post_install_message = <<MESSAGE

===========================================================

  Thanks for installing FacebookCL!
  If you have any questions or feedback, feel free to
  email me:  jubishop@facebook.com

  Just run 'facebook' to get started...

===========================================================

MESSAGE
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available."
  puts "Install it with: gem install jeweler"
end