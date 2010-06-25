module FacebookCommands; class << self
  def help(*args)
    if (args.first == 'help')
      puts 'help'
      return
    end

    if (args.empty?)
      commands = singleton_methods - ['method_missing']
      puts "Type '<command> help' or 'help <command>' for details."
      puts "  #{commands.join("\n  ")}"
    else
      send(args.shift, 'help')
    end
  end
end; end