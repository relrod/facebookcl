module FacebookCommands
  class << self
    def friends(*args)
      if args.first == 'help'
        puts 'list [returns list of your friends]'
        puts 'list <uid> [returns list of <uid>\'s friends]'
        return
      end
      
      if args.first == 'list'
        args.shift
        person = !args.empty? ? args.first : 'me'
        friends = FacebookCL.get("#{person}/friends")
        friends['data'].each do |friend|
          puts "[*] #{friend['name']}"
        end
      end
      
      if args.first == 'count'
        args.shift
        person = !args.empty? ? args.first : 'me'
        friends = FacebookCL.get("#{person}/friends")
        puts "Count: #{friends['data'].size}"
      end
    end
  end
end