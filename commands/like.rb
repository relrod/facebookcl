require 'pp'
module FacebookCommands
  class << self
    def like(*args)
      if args.first == 'help'
        puts 'like <post id>'
        return
      end
      
      like = FacebookCL.post("#{args.first}/likes")

      if not defined? like['error']
        puts "You like post id #{args.first}."
      else
        puts "You were unable to successfully like post id #{args.first}."
      end
      
    end
  end
end