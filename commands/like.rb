require 'pp'
module FacebookCommands
  class << self
    def like(*args)
      if args.first == 'help'
        puts 'like <post id>'
        return
      elsif args.first == 'list'
        args.shift
        likes = FacebookCL.get("#{args.first}/likes")
        likes['data'].each do |user|
          puts "[*] #{user['name']} (#{user['id']})"
        end
        return
      end
      
      like = FacebookCL.post("#{args.first}/likes")

      if like.class.to_s == 'Net::HTTPOK'
        puts "You like post id #{args.first}."
      else
        puts "You were unable to successfully like post id #{args.first}."
      end
      
    end
  end
end