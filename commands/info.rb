module FacebookCommands; class << self
  public

  def info(*args)
    if (args.first == 'help')
      puts 'info'
      return
    end

    info = FacebookCL.get('me')

    puts "Name: #{info['name']}"
    puts "Email: #{info['email']}"
  end
end; end