require 'pp' # Because debugging is fun.

module FacebookCommands
  class << self
    def info(*args)
      if args.first == 'help'
        puts 'info'
        return
      end
      
      friend = args.empty? ? 'me' : args.shift
      info = FacebookCL.get(friend)
      # pp info
      
      # TODO: There's got to be a better way to do this (without
      # iterating through info).
      puts "Name: #{info['first_name']} #{info['last_name']}" if info['first_name'] and info['last_name']
      puts "Location: #{info['location']['name']}" if info['location'] and info['location']['name']
      puts "Timezone (from GMT): #{info['timezone']}" if info['timezone']
      puts "Last Updated: #{info['updated_time']}" if info['updated_time']
      puts "E-mail: #{info['email']}" if info['email']
      puts "Link to Profile: #{info['link']}" if info['link']
      
      # Based on a hack I found from
      # http://www.java2s.com/Code/Ruby/String/Wrapastringwithnewlinesing.htm
      # because I'm too lazy to figure out a better way to line-wrap.
      puts "Bio: \t#{info['bio'].gsub(/(.{1,#{80}})(\s+|\Z)/, "\\1\n\t")}" if info['bio']
    end
  end
end